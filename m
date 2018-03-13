Received: from eggs.gnu.org ([2001:4830:134:3::10]:42445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1eviFt-0006gJ-EF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1eviFo-0003o8-I2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:38:09 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:42120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1eviFo-0003na-At
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 07:38:04 -0400
Received: by mail-lf0-x22b.google.com with SMTP id a22-v6so6326759lfg.9
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 04:38:04 -0700 (PDT)
Date: Tue, 13 Mar 2018 21:37:55 +1000
From: Alexey G <x1917x@gmail.com>
Message-ID: <20180313213755.00006cd9@gmail.com>
In-Reply-To: <20180313092154.GA3048@redhat.com>
References: <cover.1520867740.git.x1917x@gmail.com>
	<20180313092154.GA3048@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 00/30] Xen Q35 Bringup patches +
 support for PCIe Extended Capabilities for passed through devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org

On Tue, 13 Mar 2018 09:21:54 +0000
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

>The subject line says to expect 30 patches, but you've only sent 18 to
>the list here. I eventually figured out that the first 12 patches were
>in Xen code and so not sent to qemu-devel.
>
>For future if you have changes that affect multiple completely separate
>projects, send them as separate series. ie just send PATCH 00/18 to
>QEMU devel so it doesn't look like a bunch of patches have gone
>missing.

OK, we'll do for next versions.

>> A new domain config option was implemented: device_model_machine.
>> It's a string which has following possible values:
>> - "i440" -- i440 emulation (default)
>> - "q35"  -- emulate a Q35 machine. By default, the storage interface
>> is AHCI. =20
>
>Presumably this is mapping to the QEMU -machine arg, so it feels
>desirable to keep the same naming scheme. ie allow any of the
>versioned machine names that QEMU uses. eg any of "pc-q35-2.x"
>versioned types, or 'q35' as an alias for latest, and use
>"pc-i440fx-2.x" versioned types of 'pc' as an alias for latest, rather
>than 'i440' which is needlessly divering from the QEMU machine type.

Yes, it is translated into the '-machine' argument.

A direct mapping between the Xen device_model_machine option and QEMU
'-machine' argument won't be accepted by Xen maintainers I guess.

The main problem with this approach is a requirement to have a match
between Xen/libxl and QEMU versions. If, for example,
device_model_machine tells something like "pc-q35-2.11" and later we
downgrade QEMU to some older version we'll likely have a problem
without changing anything in the domain config. So I guess the "use the
latest available" approach for machine selection (pc, q35, etc) is the
only possible option. Perhaps having the way to specify the exact QEMU
machine name and version in a separate domain config parameter (for
advanced use) might be feasible.

Also, parameter names do not speak for themselves I'm afraid. This way
we'll have, for example, device_model_machine=3D"pc" vs
device_model_machine=3D"q35"... a bit unclear I think. This may be
obvious for a QEMU user, but many Xen users didn't get used to QEMU
machines and there might be some wondering why "q35" is not "pc" and
why "pc" is an i440 system precisely.

Another obstacle here is xen_platform_device option which indirectly
selects QEMU machine type for i440 at the moment (pc/xenfv), but this
may be addressed by controlling the Xen platform device independently
via a separate machine property or '-device xen-platform' like
Eduardo Habkost suggested.
