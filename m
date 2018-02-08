Received: from eggs.gnu.org ([2001:4830:134:3::10]:53011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ejrUH-0001Zp-M4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ejrUG-0005Ez-QU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:04:01 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ejrUG-0005EX-Jc
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:04:00 -0500
Received: by mail-wr0-x243.google.com with SMTP id f6so5845716wra.6
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 11:04:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8be47d97-4a09-eb4f-0ee2-624404b43100@redhat.com>
References: <20180208162343.30809-1-marcandre.lureau@redhat.com>
	<20180208162343.30809-3-marcandre.lureau@redhat.com>
	<8be47d97-4a09-eb4f-0ee2-624404b43100@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Feb 2018 20:03:58 +0100
Message-ID: <CAJ+F1C+TFo96++C61fkp-_GdD43VHj1=zimnFSnEUkx+e=HRZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] build-sys: enable sanitizers by
 default with --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

Hi

On Thu, Feb 8, 2018 at 6:46 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 08/02/2018 17:23, Marc-Andr=C3=A9 Lureau wrote:
>> The original commit 247724cb302af5d70c8853154b640dfabf2bbb56 was meant
>> to enable sanitizers by default when --enable-debug, but failed
>> because of a gcc static linking bug. Try to enable it back now that
>> there is a stronger check.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> I'm more afraid that there are quite a few reports from sanitizers.  I
> wonder if that makes --enable-debug unusable; as a non-user of
> --enable-debug I'm a bit wary of pushing this patch.

I understand the concern, but at the same time, people should care
about fixing those. If they want to keep ignoring them (for bad
reasons), they can --disable-sanitizers. At least, I would want to
reach a point where no ASAN regression get introduced in x86 target.
It would be nice if patchew warn on new ASAN reports for example.

>
> I've queued 1 and 2 though.
>
> Paolo
>
>> ---
>>  configure | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index beb0de6a77..700ff35383 100755
>> --- a/configure
>> +++ b/configure
>> @@ -355,7 +355,7 @@ rdma=3D""
>>  gprof=3D"no"
>>  debug_tcg=3D"no"
>>  debug=3D"no"
>> -sanitizers=3D"no"
>> +sanitizers=3D""
>>  fortify_source=3D""
>>  strip_opt=3D"yes"
>>  tcg_interpreter=3D"no"
>> @@ -5262,6 +5262,11 @@ have_ubsan=3Dno
>>  have_asan_iface_h=3Dno
>>  have_asan_iface_fiber=3Dno
>>
>> +# enable sanitizers by default if --enable-debug
>> +if test "$sanitizers" =3D "" -a "$debug" =3D "yes"; then
>> +  sanitizers=3Dyes
>> +fi
>> +
>>  if test "$sanitizers" =3D "yes" ; then
>>    if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then
>>        have_asan=3Dyes
>>
>
>



--=20
Marc-Andr=C3=A9 Lureau
