Received: from eggs.gnu.org ([2001:4830:134:3::10]:51800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1esvjT-0001a7-I7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1esvjR-0002tJ-In
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:25:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34780 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1esvjR-0002sq-CR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:25:09 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-6-marcandre.lureau@redhat.com>
	<53a8a301-0719-aca9-7b4c-90df90ccfda0@redhat.com>
	<CAJ+F1CLEiCtK4-gxb4NhFRn28Lzyy_-GFYezk=MKpzcTYTEqwA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1ea18af6-9878-edd2-cee1-6f90077f1774@redhat.com>
Date: Mon, 5 Mar 2018 20:25:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLEiCtK4-gxb4NhFRn28Lzyy_-GFYezk=MKpzcTYTEqwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 5/7] ovmf: link with Tcg2Dxe module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: edk2-devel@lists.01.org, Peter Jones <pjones@redhat.com>, Jiewen Yao <jiewen.yao@intel.com>, QEMU <qemu-devel@nongnu.org>, Javier Martinez Canillas <javierm@redhat.com>

On 03/05/18 16:45, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Feb 26, 2018 at 10:50 AM, Laszlo Ersek <lersek@redhat.com> wrot=
e:
>> On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:

>>> +  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf {
>>> +    <LibraryClasses>
>>> +      Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2Devi=
ceLibRouterDxe.inf
>>
>> Can you please explain why Tpm2DeviceLib has to be resolved differentl=
y
>> for DXE_DRIVER modules in general (see above) and for "Tcg2Dxe.inf"
>> specifically?
>>
>> Hmmm... Looks like "Tpm2DeviceLibTcg2.inf" implements the APIs via the
>> TPM2 protocol. Whereas "Tcg2Dxe.inf" itself provides that protocol, so
>> obviously it cannot rely on the protocol; it has to access the device,
>> which is done with the help of "Tpm2DeviceLibRouterDxe.inf" and the
>> "Tpm2InstanceLibDTpm.inf" that is plugged in via NULL resolution below=
.
>> Is that about correct?
>>
>> If so, can you please document it in the commit message?
>=20
> I followed the SecurityPkg.dsc, and tried some variants. This router
> pattern can be found in other places, unfortunately, I can't explain
> it. I can copy&paste your explanation if that helps.

Yes, I think we should capture it in the commit message.

I'd also like to make another attempt at explaining it to you (and me as
well :) ).


* We have a library class called Tpm2DeviceLib -- this is basically the
set of APIs declared in "SecurityPkg/Include/Library/Tpm2DeviceLib.h".
Its leading comment says "This library abstract how to access TPM2
hardware device".

There are two *sets* of APIs in "Tpm2DeviceLib.h":

(a) functions that deal with the TPM2 device:
    - Tpm2RequestUseTpm(),
    - Tpm2SubmitCommand()

    This set of APIs is supposed to be used by clients that *consume*
    the TPM2 device abstraction.

(b) the function Tpm2RegisterTpm2DeviceLib(), which is supposed to be
    used by *providers* of various TPM2 device abstractions.


* Then, we have two implementations (instances) of the Tpm2DeviceLib clas=
s:
(1) SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg2.inf
(2) SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2DeviceLibRouterDxe.inf

(1) The first library instance ("Tpm2DeviceLibTcg2.inf") implements the
APIs listed under (a), and it does not implement (b) -- see
EFI_UNSUPPORTED. In other words, this lib instance is strictly meant for
drivers that *consume* the TPM2 device abstraction. And, the (a) group
of APIs is implemented by forwarding the requests to the TCG2 protocol.

The idea here is that all the drivers that consume the TPM2 abstraction
do not have to be statically linked with a large TPM2 device library
instance; instead they are only linked (statically) with this "thin"
library instance, and all the actual work is delegated to whichever
driver that provides the singleton TCG2 protocol.

(2) The second library instance ("Tpm2DeviceLibRouterDxe.inf") is meant
for the driver that offers (produces) the TCG2 protocol. This lib
instance implements both (a) and (b) API groups.


* Here's how things fit together:

(i) The "SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.inf"
library instance (which has no lib class) is linked into "Tcg2Dxe.inf"
via NULL class resolution. This simply means that before the
"Tcg2Dxe.inf" entry point function is entered, the constructor function
of "Tpm2InstanceLibDTpm.inf" will be called.

(ii) This Tpm2InstanceLibDTpmConstructor() function calls API (b), and
registers its own actual TPM2 command implementation with the
"Tpm2DeviceLibRouter" library instance (also linked into the Tcg2Dxe
driver). This provides the back-end for the API set (a).

       TCG2 protocol provider (Tcg2Dxe.inf driver) launches
                    |
                    v
  NULL class: Tpm2InstanceLibDTpm instance construction
                    |
                    v
  Tpm2DeviceLib class: Tpm2DeviceLibRouter instance
         backend registration for API set (a)

(iii) The Tcg2Dxe driver exposes the TCG2 protocol.

(iv) A TPM2 consumer calls API set (a) via lib instance (1). Such calls
land in Tcg2Dxe, via the protocol.

(v) Tcg2Dxe serves the protocol request by forwarding it to API set (a)
from lib instance (2).

(vi) Those functions call the "backend" functions registered by
Tpm2DeviceLibDTpm in step (ii).

     TPM 2 consumer driver
              |
              v
Tpm2DeviceLib class: Tpm2DeviceLibTcg2 instance
              |
              v
       TCG2 protocol interface
              |
              v
TCG2 protocol provider: Tcg2Dxe.inf driver
              |
              v
Tpm2DeviceLib class: Tpm2DeviceLibRouter instance
              |
              v
   NULL class: Tpm2InstanceLibDTpm instance
      (via earlier registration)
              |
              v
     TPM2 chip (actual hardware)


* So that is the "router" pattern in edk2. Namely,

- Consumers of an abstraction use a thin library instance.

- The thin library instance calls a firmware-global (singleton) service,
  i.e. a PPI (in the PEI phase) or protocol (in the DXE phase).

- The PEIM providing the PPI, or the DXE driver providing the protocol,
  don't themselves implement the actual service either. Instead they
  offer a "registration" service too, and they only connect the incoming
  "consumer" calls to the earlier registered back-end(s).

- The "registration service", for back-ends to use, may take various
  forms.

  It can be exposed globally to the rest of the firmware, as
  another member function of the PPI / protocol structure. Then backends
  can be provided by separate PEIMs / DXE drivers.

  Or else, the registration service can be exposed as just another
  library API. In this case, the backends are provided as NULL class
  library instances, and a platform  DSC file links them into the PEIM /
  DXE driver via NULL class resolutions. The backend lib instances call
  the registration service in their own respective constructor
  functions.

>>
>>> +      NULL|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm=
.inf
>>> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSh=
a1.inf
>>
>> Again -- is SHA1 required?
>=20
> The linux kernel doesn't yet read the EFI_TCG2_EVENT_LOG_FORMAT_TCG_2,
> which is required for crypto-agile log. In fact, only upcoming 4.16
> adds support EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2...
>=20
> Any major drawback in keeping sha1 enabled? (same for Pei)

Likely not a major drawback.

I just remember that, for a while now, it's been "time to walk, but not
run, to the fire exits. You don't see smoke, but the fire alarms have
gone off" --
<https://www.schneier.com/blog/archives/2005/02/cryptanalysis_o.html>.
Note the year. :)

So I prefer avoiding SHA1 in new things, for general hygiene. If we
can't avoid SHA1, I'm OK with pulling it in, though.

Thanks!
Laszlo
