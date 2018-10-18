Received: from eggs.gnu.org ([2001:4830:134:3::10]:58071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gD90r-0005bJ-Hg
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gD90m-0005tr-M6
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:10:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gD90m-0005tQ-F0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:10:52 -0400
Received: by mail-wr1-x434.google.com with SMTP id l6-v6so33466334wrt.1
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 07:10:52 -0700 (PDT)
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net> <20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
	<20181017155637.GC31060@habkost.net>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <29ed5e33-18d5-7c86-d946-02e96b9bff68@gmail.com>
Date: Thu, 18 Oct 2018 17:11:45 +0300
MIME-Version: 1.0
In-Reply-To: <20181017155637.GC31060@habkost.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] No more chameleon devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Laine Stump <laine@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

Hi Eduardo,

On 10/17/18 6:56 PM, Eduardo Habkost wrote:
> (CCing Marcel, in case he has extra details on the complex
> Conventional/Express bus/device plugging rules)
>
> On Wed, Oct 17, 2018 at 07:57:39AM +0200, Markus Armbruster wrote:
>> Laine Stump <laine@redhat.com> writes:
>>
>> [...]
>>> In the end, having a device that changed PCI ID depending on what kind
>>> of slot it was plugged into was an idea "too clever for its own good",
>>> should be avoided when new devices are added in the future, and we
>>> should at least provide an alternative that doesn't do that for existing
>>> devices.
>> That means for each chameleon PCI/PCIe device:
>>
>> * create a pair of devices that can only go into one kind of slot
>>
>> * deprecate the chameleon
>>
>> Yes, please!  Volunteers?
>>
>> Do we have similar chameleons outside PCI?
> I'm worried that we could be trying to address multiple issues at
> the same time, and I'm not sure yet if we should address all of
> them in one take.
>
> Right now we need to differentiate non-transitional and
> transitional virtio devices, for a few reasons:
> * They have different PCI IDs;
> * Legacy drivers don't work with non-transitional devices;
> * Transitional virtio devices can be plugged to Conventional PCI
>    buses; non-transitional ones can't.
>
> This patch addresses that problem.
>
> You seem to be talking about a different issue:
> * Some devices (including transitional virtio) can be plugged on
>    both Conventional PCI and PCI Express buses (I will call those
>    devices "hybrid PCI devices").
>
> The former is a practical problem: management software needs to
> be able to ask for a transitional virtio device, depending o the
> guest OS being run.
>
> Addressing the latter seems more complex (it would affect other
> devices, not just virtio), and I don't see which practical
> problems it would solve.
>
> I see some problems it wouldn't solve, though: the system
> wouldn't be able to represent the fact that transitional virtio
> devices can still work on PCI Express buses, as long as they
> support PIO bars; or that Conventional PCI devices can be plugged
> to PCI Express root buses.
>
> I don't see problems caused by hybrid conventional/express PCI
> devices.  The original problem with virtio devices was just not
> being hybrid, it was lying about being hybrid: non-transitional
> virtio devices are hybrid, but transitional virtio devices
> aren't.
>
> I wouldn't be against abolishing hybrid PCI devices completely if
> somebody volunteers to do the work.

+1  -- GSOC Project?

>   I just don't see which
> problems this would solve.

Maybe would be a step toward a clean "socket-device" modeling (what goes 
where)
and also QEMU emulation would be cleaner since in bare metal you cannot
plug a PCIe device into a PCI slot and vice-versa or have the same device ID
for both a PCI and a PCIe device.

Thanks,
Marcel
