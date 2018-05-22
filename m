Received: from eggs.gnu.org ([2001:4830:134:3::10]:38198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL7ub-0004Ul-Ur
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL7uW-0005gN-56
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:05:13 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:41313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL7uW-0005gA-05
	for qemu-devel@nongnu.org; Tue, 22 May 2018 10:05:08 -0400
Received: by mail-ot0-x242.google.com with SMTP id t1-v6so21080663oth.8
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 07:05:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503214437.2749.37878.stgit@gimli.home>
References: <20180503213458.2749.28566.stgit@gimli.home>
	<20180503214437.2749.37878.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 15:04:46 +0100
Message-ID: <CAFEAcA_sg_kpHGM+YGcziUCmqtsOcJ563mBqb3xvN0sMpz9XUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/6] scripts/update-linux-headers:
 Update handling of __aligned_u64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>, kvm-devel <kvm@vger.kernel.org>

On 3 May 2018 at 22:44, Alex Williamson <alex.williamson@redhat.com> wrote:
> We'll currently replace any 'u64' with a 'uint64_t' including when
> it's embedded in an '__aligned_u64', creating a '__aligned_uint64_t'
> which doesn't exist.  Add another sed entry to find these and convert
> them back to their original form.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  scripts/update-linux-headers.sh |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index a017b53d8765..dd74cc8d5223 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -56,6 +56,7 @@ cp_portable() {
>          -e 's/__s\([0-9][0-9]*\)/int\1_t/g' \
>          -e 's/__le\([0-9][0-9]*\)/uint\1_t/g' \
>          -e 's/__be\([0-9][0-9]*\)/uint\1_t/g' \
> +        -e 's/__aligned_uint\([0-9][0-9]*\)_t/__aligned_u\1/g' \
>          -e 's/"\(input-event-codes\.h\)"/"standard-headers\/linux\/\1"/' \
>          -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
>          -e 's/__bitwise//' \

Hi -- I just ran into this as well, but this fix looks odd. This
bit of the script is supposed to generate portable headers,
so we need to do something with __aligned_u64; we can't just
leave it the way it is. We should presumably be turning it into
some typedef which we have a definition of in the QEMU headers.

(That u\([0-9][0-9]*\) substitution is really broad; we should
probably switch to using perl instead so we can use regexes that
match on word-boundaries so we only change what we intend to.)

thanks
-- PMM
