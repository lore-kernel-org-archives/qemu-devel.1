Received: from eggs.gnu.org ([2001:4830:134:3::10]:36792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1d15M9-0008Dq-ME
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1d15M4-0005I6-I6
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:14:17 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andr2000@gmail.com>) id 1d15M4-0005Hy-BT
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 02:14:12 -0400
Received: by mail-wm0-x242.google.com with SMTP id u65so997620wmu.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 23:14:12 -0700 (PDT)
References: <1491903346-16075-1-git-send-email-andr2000@gmail.com>
	<alpine.DEB.2.10.1704131704560.2759@sstabellini-ThinkPad-X260>
	<693ebf90-00d7-823e-4db8-9b9686e56941@gmail.com>
	<f5ce758f-5f31-32d6-7e19-8c3a83017bab@suse.com>
	<alpine.DEB.2.10.1704141035090.23677@sstabellini-ThinkPad-X260>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <2da8fea2-6293-c1b5-c671-ae16b8445de4@gmail.com>
Date: Thu, 20 Apr 2017 09:14:09 +0300
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1704141035090.23677@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] configure: introduce
 --enable-xen-fb-backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>, Juergen Gross <jgross@suse.com>
Cc: vlad.babchuk@gmail.com, qemu-devel@nongnu.org, andrii.anisov@gmail.com, olekstysh@gmail.com, al1img@gmail.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, joculator@gmail.com

On 04/14/2017 08:52 PM, Stefano Stabellini wrote:
> On Fri, 14 Apr 2017, Juergen Gross wrote:
>> On 14/04/17 08:06, Oleksandr Andrushchenko wrote:
>>> On 04/14/2017 03:12 AM, Stefano Stabellini wrote:
>>>> On Tue, 11 Apr 2017, Oleksandr Andrushchenko wrote:
>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>>
>>>>> For some use cases when Xen framebuffer/input backend
>>>>> is not a part of Qemu it is required to disable it,
>>>>> because of conflicting access to input/display devices.
>>>>> Introduce additional configuration option for explicit
>>>>> input/display control.
>>>> In these cases when you don't want xenfb, why don't you just remove
>>>> "vfb" from the xl config file? QEMU only starts the xenfb backend when
>>>> requested by the toolstack.
>>>>
>>>> Is it because you have an alternative xenfb backend? If so, is it really
>>>> fully xenfb compatible, or is it a different protocol? If it is a
>>>> different protocol, I suggest you rename your frontend/backend PV device
>>>> name to something different from "vfb".
>>>>
>>> Well, offending part is vkbd actually (for multi-touch
>>> we run our own user-space backend which supports
>>> kbd/ptr/mtouch), but vfb and vkbd is the same backend
>>> in QEMU. So, I am ok for vfb, but just want vkbd off
>>> So, there are 2 options:
>>> 1. At compile time remove vkbd and still allow vfb
>>> 2. Remove xenfb completely, if acceptable (this is my case)
>> What about adding a Xenstore entry for backend type and let qemu test
>> for it being not present or containing "qemu"?
sounds reasonable
> That is what we do for the console, using the xenstore node "type". QEMU
> is "ioemu" while xenconsoled is "xenconsoled". Weirdly, instead of a
> backend node, it is a read-only frontend node, see
> tools/libxl/libxl_console.c:libxl__device_console_add.
>
> Oleksandr, I am sorry to feature-creep this simple patch, but I think
> Juergen is right. But we cannot do it just for one protocol. We need to
> introduce a generic way to enable/disable backends in QEMU. Using a
> xenstore node is OK.
agree
>
> We could do exactly the same as the PV console, thus "type" = "ioemu",
> read-only, under the frontend xenstore directory. Or we could introduce
> new nodes. I would probably go for "backend-type" = "qemu" under the
> backend xenstore directory. I don't have a strong opinion about this. In
> the example below I'll use the PV console convention.
>
> For starters:
>
> * libxl needs to write the "type" node to xenstore for *all* protocols.
>    The "type" is not yet configurable.
> * qemu reads them for all backends, proceeds if "type" = "ioemu"
>
> These should be two simple patches. Stage 2:
>
> * we add options in the xl config file to configure any backend, libxl
>    set "type" accordingly (Maybe not *any*, but vif, vkbd, vfb could all
>    have a "type". It is OK if you only add an option for vkbd.)
> * non-QEMU backends, in particular Linux backends, also read the "type"
>    node and proceed if it's "linux"
>
> Does this sound OK to you?
For the first take it does, but I'll get back to it a bit later
Actually the purpose of the change was to find a way
we can live with backends implemented in QEMU and user-space
and how they can co-exist

Thank you,
Oleksandr
