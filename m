Received: from eggs.gnu.org ([2001:4830:134:3::10]:36237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNweD-0003G0-2z
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNweC-00059y-3N
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:35:25 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNweB-00059o-S2
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 03:35:24 -0400
Received: by mail-wr0-x231.google.com with SMTP id r103so11253551wrb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 00:35:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498116800.25651.3.camel@redhat.com>
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-22-f4bug@amsat.org>
	<1498116800.25651.3.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 08:35:02 +0100
Message-ID: <CAFEAcA932_0oPwBxOHg886mTQu9O4wWR2bYH7Xd+Cef_Exr7RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 21/21] ui/vnc: silent unuseful OSX
 clang warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 22 June 2017 at 08:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
> diff --git a/ui/Makefile.objs b/ui/Makefile.objs
>> index 3369451285..08fb573a48 100644
>> --- a/ui/Makefile.objs
>> +++ b/ui/Makefile.objs
>> @@ -6,6 +6,14 @@ vnc-obj-y +=3D vnc-auth-vencrypt.o
>>  vnc-obj-$(CONFIG_VNC_SASL) +=3D vnc-auth-sasl.o
>>  vnc-obj-y +=3D vnc-ws.o
>>  vnc-obj-y +=3D vnc-jobs.o
>> +ifeq ($(CONFIG_VNC_SASL),y)
>> +# silent OSX SASL warnings (from https://stackoverflow.com/a/7406994
>> ):
>> +# because OpenSSL doesn=E2=80=99t offer API compatibility between versi=
ons,
>> [...] Apple
>> +# can't provide security updates without breaking existing apps, so
>> is migrating
>> +# from OpenSSL to Common Crypto.
>> +vnc.o-cflags :=3D -Wno-deprecated-declarations
>> +vnc-auth-sasl.o-cflags :=3D -Wno-deprecated-declarations
>> +endif
>
> Hmm, does clang understand "#pragma GCC diagnostic" ?
>
> If so, then this can be done in in the code not the makefiles, and also
> selectively for osx only.

It does have some diagnostic pragma support. The awkward part is
that it has to  be in force at the point where the deprecated
function is used, not where it's declared. So you can't just wrap
the #include of the ssl header in pragmas, you'd have to either
do it at every callsite or else over the whole .c file.

thanks
-- PMM
