Received: from eggs.gnu.org ([2001:4830:134:3::10]:58905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cvIXX-0006Tj-A9
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 03:06:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cvIXS-00013R-BU
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 03:06:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cvIXS-00012m-3S
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 03:06:02 -0400
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
	<CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
	<20170403135445.GD1910@thinpad.lan.raisama.net>
	<CAFEAcA-+imjX_kfxPo6Vue-bX8HZo8ZV8s7XmyTNj7_GTd4Lrg@mail.gmail.com>
	<20170403183043.GF1910@thinpad.lan.raisama.net>
	<CAFEAcA9s6+WMEsMxK0Twac=TCfU-Wf4ouB1CNvJ9uDj++fGJVQ@mail.gmail.com>
	<20170403200550.GI1910@thinpad.lan.raisama.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d148549c-d689-3054-bfc8-7152a4e55ad2@redhat.com>
Date: Tue, 4 Apr 2017 09:05:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170403200550.GI1910@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 03.04.2017 22:05, Eduardo Habkost wrote:
> On Mon, Apr 03, 2017 at 08:42:12PM +0100, Peter Maydell wrote:
>> On 3 April 2017 at 19:30, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> On Mon, Apr 03, 2017 at 03:08:06PM +0100, Peter Maydell wrote:
>>>> On 3 April 2017 at 14:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>>> This, on the other hand, currently works:
>>>>>   $ qemu-system-x86_64 -M q35 -device unimplemented-device,size=1024,name=foo
>>>>
>>>> That's a bug in the q35 machine or the handling of -device
>>>> on non-platform-bus systems, though, isn't it? The default
>>>> for all sysbus devices has always been "you can't use
>>>> -device with this", [...]
>>>
>>> This was true until 2014, only. commit
>>> 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 changed sys-bus-device
>>> to have cannot_instantiate_with_device_add_yet=false. See patch
>>> 03/19 for more detailed info.
>>
>> That commit shouldn't cause this problem -- unless the
>> machine sets has_dynamic_sysbus then the machine_init_notify()
>> that commit adds will cause it to complain.
>>
>> I think the bug was introduced much later, in bf8d4924 in 2016,
>> when q35 had the has_dynamic_sysbus flag added but without
>> any code to restruct this to a whitelist of working
>> devices. (In fact you can see in that commit a very
>> minimal attempt to blacklist a few devices.)
> 
> It's true that the problem happened when q35 set
> has_dynamic_sysbus=1 without a whitelist. The point of this
> series is to make a per-machine-type whitelist unnecessary.
> 
>>
>> The commit message says only intel-iommu was supposed to
>> be -device creatable, so it should have been the only
>> thing on the whitelist.
> 
> There was a thread about it (Subject: "q35 and sysbus devices"),
> and nobody knew for sure if the q35 whitelist was supposed to
> have *-iommu only, or not.
> 
> The conclusion of that thread is that we can simply use
> cannot_instantiate_with_device_add_yet to build the whitelist, if
> the field was set consistently. This series renames
> cannot_instantiate_with_device_add_yet to user_creatable, and
> sets it consistently.

I don't think that this will always work. While you can clearly mark
those devices that can never be added dynamically, there might also be
some devices that only work on certain machines. For example, there
might be devices that only work on the "ppce500" machine, but do not
work on the "pseries" machine. So we always need some kind of
whitelisting for the machines that have a dynamic sysbus.

 Thomas
