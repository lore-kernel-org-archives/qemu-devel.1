Received: from eggs.gnu.org ([2001:4830:134:3::10]:55873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etw4Y-0004Wp-JS
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1etw4X-0002N7-Nc
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:59:06 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1etw4X-0002Ms-Gg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:59:05 -0500
Received: by mail-wm0-x22b.google.com with SMTP id 188so11194392wme.1
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 05:59:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <06C8AB66E78EE34A949939824ABE2B313B651F39@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<06C8AB66E78EE34A949939824ABE2B313B651F39@shsmsx102.ccr.corp.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Mar 2018 14:59:03 +0100
Message-ID: <CAJ+F1CKuHzO-F3XbjqQyLL49JipsR+Sk8zFy1ZuMssUz_71qvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 0/8] RFC: ovmf: preliminary TPM2
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Shi, Steven" <steven.shi@intel.com>
Cc: "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "lersek@redhat.com" <lersek@redhat.com>, "pjones@redhat.com" <pjones@redhat.com>, "Yao,
	Jiewen" <jiewen.yao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi

On Thu, Mar 8, 2018 at 1:31 PM, Shi, Steven <steven.shi@intel.com> wrote:
> Hi Marcandre,
>> I test with qemu & swtpm/libtpms (tpm2 branches, swtpm_setup.sh --tpm2 -=
-tpm-state tpmstatedir)
>> $ swtpm socket --tpmstate tpmstatedir --ctrl type=3Dunixio,path=3Dtpmsoc=
k  --tpm2 &
>
> Where is the swtpm_setup.sh? And could you tell how to build & install th=
e swtpm?
>

You need to compile & install libtpms & swtpm :

git clone -b tpm2-preview.rev146.v2 https://github.com/stefanberger/libtpms
cd libtpms
autoreconf -vfi && ./configure --with-tpm2 --with-openssl  && make install

git clone -b tpm2-preview.v2 https://github.com/stefanberger/swtpm
cd swtpm
autoreconf -vfi && ./configure --with-openssl && make install

Then you can run:
mkdir tpmstatedir
swtpm_setup.sh --tpm2 --tpm-state tpmstatedir

Run the emulator:
swtpm socket --tpmstate dir=3Dtpmstatedir --ctrl
type=3Dunixio,path=3Dtpmemu.sock  --tpm2

Run qemu (from git) with ovmf (with this series):
qemu ... -chardev socket,id=3Dchrtpm,path=3Dtpmemu.sock -tpmdev
emulator,id=3Dtpm0,chardev=3Dchrtpm  -device tpm-crb,tpmdev=3Dtpm0
-drive if=3Dpflash,format=3Draw,file=3DOVMF_CODE.fd,readonly -drive
if=3Dpflash,format=3Draw,file=3DOVMF_VARS.fd ..

cheers
--=20
Marc-Andr=C3=A9 Lureau
