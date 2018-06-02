Received: from eggs.gnu.org ([2001:4830:134:3::10]:37600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fP23l-0007BL-21
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fP23h-0002Km-3w
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:38:49 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:40759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fP23g-0002GE-Rn
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 04:38:45 -0400
Received: by mail-wm0-x22a.google.com with SMTP id x2-v6so6116560wmh.5
	for <qemu-devel@nongnu.org>; Sat, 02 Jun 2018 01:38:44 -0700 (PDT)
References: <1526945967-9687-1-git-send-email-cota@braap.org>
	<ff49bf54-3d5c-c2a4-95cd-3cb8c2efab51@linaro.org>
	<ada5eac5-eceb-b330-6f12-ac6e9c58268d@linaro.org>
	<20180602002905.GA19122@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180602002905.GA19122@flamenco>
Date: Sat, 02 Jun 2018 09:38:42 +0100
Message-ID: <87vab1zip9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 00/17] tcg: tb_lock removal redux v3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> On Wed, May 30, 2018 at 16:05:14 -0700, Richard Henderson wrote:
>> On 05/30/2018 03:46 PM, Richard Henderson wrote:
>> > Thanks.  Queued to tcg-next.
>> Hmph.  Unqueued, at least for now.
>>
>> ERROR:/home/rth/work/qemu/qemu/accel/tcg/translate-all.c:615:page_unlock=
__debug:
>> assertion failed: (page_is_locked(pd))
>
> Gaah, sorry. In v3 forgot to call the lock__debug function from
> a successful trylock. I tested v3 on aarch64, which explains why
> I didn't catch the bug. Fixed now:
>
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -704,6 +704,7 @@ static bool page_entry_trylock(struct page_entry *pe)
>      if (!busy) {
>          g_assert(!pe->locked);
>          pe->locked =3D true;
> +        page_lock__debug(pe->pd);
>      }
>      return busy;
>  }
>
> I also added the following, which cannot hurt:
>
> diff --git a/exec.c b/exec.c
> index afc37e0..e874d67 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2493,6 +2493,7 @@ void memory_notdirty_write_complete(NotDirtyInfo *n=
di)
>  {
>      if (ndi->pages) {
>          page_collection_unlock(ndi->pages);
> +        ndi->pages =3D NULL;
>      }
>
> (Note that calling page_collection_unlock twice on that pointer
> would blow up.)
>
> The above two one-liners are the only code changes between v3 and v4.
> I also added Alex's R-b tag for the qht patch.
>
> I've boot-tested v4 on aarch64, arm, x86_64-softmmu, riscv64, sh4,
> sparc, s390x, ppc64 and or1k, with and without TCG debug.
>
> You can fetch v4 from:
>   https://github.com/cota/qemu/tree/tb-lock-removal-redux-v4

I've just spun up v4 and it still works on aarch64 and now also passes
the coldfire test rich passed me. So have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

For those two.

>
> Thanks,
>
> 		Emilio


--
Alex Benn=C3=A9e
