Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cMJIZ-0003It-Kq
	for Qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ilg@livius.net>) id 1cMJIW-0004iK-EO
	for Qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:50:03 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ilg@livius.net>) id 1cMJIW-0004hH-62
	for Qemu-devel@nongnu.org; Wed, 28 Dec 2016 13:50:00 -0500
Received: by mail-wm0-x22b.google.com with SMTP id k184so120202950wme.1
	for <Qemu-devel@nongnu.org>; Wed, 28 Dec 2016 10:49:58 -0800 (PST)
Received: from [172.16.62.12] ([109.99.239.84])
	by smtp.gmail.com with ESMTPSA id
	e5sm61902468wma.12.2016.12.28.10.49.55 for <Qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Dec 2016 10:49:56 -0800 (PST)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Message-Id: <6205DF8A-7643-432F-88FF-12B1E9DEF5D8@livius.net>
Date: Wed, 28 Dec 2016 20:49:55 +0200
Subject: [Qemu-devel] CMSIS SVD based peripheral definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developer <Qemu-devel@nongnu.org>

CMSIS SVD
---------

The latest release of GNU ARM Eclipse QEMU (2.8.0-20161227) introduced a =
new technology for implementing peripherals, based on standard CMSIS SVD =
definitions (http://www.keil.com/pack/doc/CMSIS/SVD/html/index.html).

The SVD files are large XML files produced by the silicon vendors, and =
generally are considered the final hardware reference for the Cortex-M =
devices, so they are expected to provide the most accurate peripheral =
emulation.

For convenience, the original SVD files are converted to JSON files, =
which are generally easier to parse.=20

There is one file for each sub-family; the files currently used by GNU =
ARM Eclipse QEMU are grouped in the devices folders:

	=
https://github.com/gnuarmeclipse/qemu/tree/gnuarmeclipse-dev/gnuarmeclipse=
/devices


Please note that some devices may include multiple instances of similar =
peripherals, for example multiple timers, with each instance slightly =
different from the others. The SVD files include all these differences, =
so strictly following the content of the SVD files is mandatory; =
extracting a definition common to all instances may seem attractive, but =
it is not realistic, since it may not be accurate for all instances.


Peripheral/register/bitfield
----------------------------

The basic objects used to implement peripherals are the 'registers'; a =
peripheral is actually an array of registers, each with its value.

For convenience, registers can be viewed as collections of bitfields; =
bitfield objects do not have their own values, reading a bitfield refers =
to the parent register, which is masked, shifted and finally returned.

Accessing bitfields is quite straightforward:

const char *enabling_bit_name =3D =
"/machine/mcu/stm32/RCC/AHB1ENR/GPIOAEN";
state->enabling_bit =3D OBJECT(cm_device_by_name(enabling_bit_name));
// ...
if (register_bitfield_is_non_zero(state->enabling_bit)) {
  // ...
}


Generated code
--------------

In addition to using vendor SVD files, GNU ARM Eclipse QEMU goes one =
step further, by generating most of the peripheral code, to the point =
that new peripherals can be added simply be adding the generated files =
to the project.

Examples of the files currently used are in sub subfolders of the =
devices/support folder:

	=
https://github.com/gnuarmeclipse/qemu/tree/gnuarmeclipse-dev/gnuarmeclipse=
/devices/support


As per the current STM32 implementation, to avoid redundancy, each =
peripheral file includes definitions for all families; adding a new =
device implies generating the code for the new device sub-family, and =
copy/paste-ing the required code in the peripheral implementation.

An example of such a peripheral implementation is the SYSFCG:

	=
https://github.com/gnuarmeclipse/qemu/blob/gnuarmeclipse-dev/hw/cortexm/st=
m32/syscfg.c



Supported devices
-----------------

GNU ARM Eclipse QEMU 2.8 supports the following boards:

  Maple                LeafLab Arduino-style STM32 microcontroller board =
(r5)
  NUCLEO-F103RB        ST Nucleo Development Board for STM32 F1 series
  NUCLEO-F411RE        ST Nucleo Development Board for STM32 F4 series
  NetduinoGo           Netduino GoBus Development Board with STM32F4
  NetduinoPlus2        Netduino Development Board with STM32F4
  OLIMEXINO-STM32      Olimex Maple (Arduino-like) Development Board
  STM32-E407           Olimex Development Board for STM32F407ZGT6
  STM32-H103           Olimex Header Board for STM32F103RBT6
  STM32-P103           Olimex Prototype Board for STM32F103RBT6
  STM32-P107           Olimex Prototype Board for STM32F107VCT6
  STM32F0-Discovery    ST Discovery kit for STM32F051 lines
  STM32F4-Discovery    ST Discovery kit for STM32F407/417 lines
  STM32F429I-Discovery ST Discovery kit for STM32F429/439 lines

Supported MCUs:
  STM32F051R8
  STM32F103RB
  STM32F107VC
  STM32F405RG
  STM32F407VG
  STM32F407ZG
  STM32F411RE
  STM32F429ZI

Functionally, the boards include animated LEDs and active push buttons =
(reset and user).


Test projects (blinky) for all supported boards are available from

	https://github.com/gnuarmeclipse/eclipse-qemu-test-projects


Conclusion
----------

Although implementing peripherals remains a challenge, using the SVD =
definitions, plus the tools to generate code, significantly improve and =
simplify the process.

Unfortunately, SVD files are available only for Cortex-M devices, but I =
think that, when not available, creating the JSON files and using the =
automated code generator is still easier than manually implementing the =
peripherals.


Personally I plan to use this technology to re-define the system =
Cortex-M devices, which, right now, are improperly implemented.


Regards,

Liviu
