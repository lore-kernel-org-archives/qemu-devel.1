Received: from eggs.gnu.org ([2001:4830:134:3::10]:40053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKj1d-000308-Kk
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gKj1Y-0006jb-HT
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:03:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gKj1Y-0006j5-7w
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:03:00 -0500
References: <20180924092120.GA30163@caravaggio>
	<7c2b477e-bdac-c887-2510-82fe04acdcfe@redhat.com>
	<87b22690-e39c-3b46-dcb4-f6abc3213142@redhat.com>
	<CAFEAcA8yHb4MdtsJuXcswQp93DN5tSeN9dn8AWWL9se0DKvdcg@mail.gmail.com>
	<41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<CAFEAcA9oCs+Y1fnY8dOR16n_Hn7PaHziL7K0HZK6=BAd_Gyecg@mail.gmail.com>
	<e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<c6bbfeb8-53c5-0e0c-cf36-14e586cfb581@redhat.com>
	<a0decaa7-d83b-b0ad-60ea-aa0890feb905@redhat.com>
	<28af4bea-e017-cdab-e5e4-a9809cb2e409@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15d0b50a-6374-d520-e85c-2e73833a046c@redhat.com>
Date: Thu, 8 Nov 2018 13:02:54 +0100
MIME-Version: 1.0
In-Reply-To: <28af4bea-e017-cdab-e5e4-a9809cb2e409@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "Zhong, Yang" <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 08/11/2018 11:14, Thomas Huth wrote:
> On 2018-11-08 10:55, Paolo Bonzini wrote:
>> On 07/11/2018 20:30, Thomas Huth wrote:
>>> On 2018-11-07 20:24, Eduardo Habkost wrote:
>>>> On Wed, Nov 07, 2018 at 06:39:54PM +0100, Paolo Bonzini wrote:
>>>>> On 07/11/2018 16:41, Samuel Ortiz wrote:
>>>>>> - The Kconfig parser would be used to generate the equivalent of w=
hat we
>>>>>>   currently have under default-configs/
>>>
>>> I think we would still have something like default-configs - but ther=
e
>>> would only be the bare minimum config switches in there, the rest wou=
ld
>>> be pulled in by dependencies.
>>
>> Yes, in theory default-configs would end up empty, except for possibly
>> some commented lines to show the "default y" symbols for the target.
>=20
> I think we should enable the machines in the default configs (and maybe
> optional devices that are not automatically selected by machines), e.g.=
:
>=20
> CONFIG_I440FX=3Dy
> CONFIG_Q35=3Dy
> CONFIG_VIRTPC=3Dy
> CONFIG_ISAPC=3Dy
> CONFIG_VIRTIO=3Dy
> CONFIG_PARALLEL=3Dy
>=20
> In configs/nemu (or configs/lean-kvm or however we'll call it), you wil=
l
> then only have:
>=20
> CONFIG_Q35=3Dy
> CONFIG_VIRTPC=3Dy
> CONFIG_VIRTIO=3Dy
>=20
> Would that make sense?

It would, however it would be hard to draw a line between which devices
are enabled by default or not.  I think in particular all devices that
currently are in default-configs/{hyperv,pci,sound,usb,virtio}.mak
should be "default y".  CONFIG_PARALLEL would be in a hypothetical
isa.mak and also "default y".

One example that we discussed of devices that should not be "default y"
is stuff like various I2C sensors (CONFIG_TMP105 for example); these
should not be included in x86 targets just because x86 has an I2C/SMBus
controller in it.  So for example tmp105 should probably be select-ed by
CONFIG_ASPEED and CONFIG_NSERIES.

Let me reiterate that your proposal _also_ makes sense, in fact it's
exactly it is done in the 2015 branch.  However, if everything were
"default y" and we write a script to write out the selected
configuration symbols to default-configs/ file, the difference would be
mostly that the lines in default-configs/ will look like
"#CONFIG_I440FX=3Dy" instead of "CONFIG_I440FX=3Dy".

And in fact, the latter would be nicer for people who want to modify
default-configs/ to specify a few boards and devices explicitly[1].  For
such people (which include both the RHEL QEMU and the NEMU maintainers)
after a rebase you would not get any new board or device.  So I'm
inclined more towards empty default-configs/ file, with comments
mentioning what can be enabled.

Paolo
