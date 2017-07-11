Received: from eggs.gnu.org ([2001:4830:134:3::10]:51364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUpuj-00074n-PM
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dUpug-0006UV-MP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:48:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dUpug-0006TY-CL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 03:48:54 -0400
References: <1499237876.3041.4.camel@linux.intel.com>
	<6ad73f55-c48a-c083-e0ef-b8ac162ec989@redhat.com>
	<5233eee1-a017-ccae-3458-762c9e86902c@redhat.com>
	<20170707133949.GH10776@localhost.localdomain>
	<20170707181642-mutt-send-email-mst@kernel.org>
	<20170707180358.GA12152@localhost.localdomain>
	<626ce419-8418-a4a2-88d3-b61bf20bbb32@redhat.com>
	<20170710135943.GG12152@localhost.localdomain>
	<20170710194345-mutt-send-email-mst@kernel.org>
	<20170710174730.GL12152@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <063778b8-d517-dcac-3c83-95076604a16c@redhat.com>
Date: Tue, 11 Jul 2017 09:48:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170710174730.GL12152@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: libvir-list@redhat.com, "Tian, Kevin" <kevin.tian@intel.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Laszlo Ersek <lersek@redhat.com>

On 10.07.2017 19:47, Eduardo Habkost wrote:
> (CCing libvir-list)
> 
> On Mon, Jul 10, 2017 at 07:45:54PM +0300, Michael S. Tsirkin wrote:
>> On Mon, Jul 10, 2017 at 10:59:43AM -0300, Eduardo Habkost wrote:
>>> On Mon, Jul 10, 2017 at 10:42:26AM +0300, Marcel Apfelbaum wrote:
>>>> On 07/07/2017 21:03, Eduardo Habkost wrote:
>>>>> On Fri, Jul 07, 2017 at 06:17:57PM +0300, Michael S. Tsirkin wrote:
>>>>>> On Fri, Jul 07, 2017 at 10:39:49AM -0300, Eduardo Habkost wrote:
>>>>>>> On Wed, Jul 05, 2017 at 12:32:10PM +0300, Marcel Apfelbaum wrote:
>>> [...]
>>>>>>>>
>>>>>>>> The upper layers should manage the defaults by themselves so
>>>>>>>> are not supposed to be affected.
>>>>>>>
>>>>>>> But they would be.  libvirt uses the default machine-type from
>>>>>>> QEMU.
>>>>>>
>>>>>> How about extending the command for supported machines with a
>>>>>> recommended machine type, and teaching libvirt to use that?
>>>>>
>>>>> I don't think QEMU has enough information to decide if it should
>>>>> recommend "q35" or "pc".
>>>>
>>>> We don't really need a complicated rule set, we would just recommend q35
>>>> by default. Libvirt will try to create the default machine and if fails
>>>> for some reason (what would it be?) it can switch to PC.
>>>>
>>>> The advanced logic would be "old systems should use PC", where old
>>>> means Windows XP and before and so on. But this logic should appear
>>>> in management layers above.
>>>
>>> In this case, is there any difference between "changing the
>>> default to q35" and "recommending q35", for libvirt users?
>>>
>>> -- 
>>> Eduardo
>>
>> No but libvirt users do not manage e.g. pci slots manually.
>> They do not use the -cdrom flag.
>> Etc.
>> So changing the default is unlikely to break things for them.
>>
> 
> I see.  If this part is really true (can libvirt developers
> confirm that?), then the proposed end result makes sense (not
> having a default for running QEMU directly, but changing default
> to "q35" for people using libvirt).
> 
> But I don't see why we would need a new mechanism to make QEMU
> recommend a machine-type for libvirt, if libvirt could simply
> choose its own default (or maybe also refuse to pick a default,
> if libvirt developers decide that's the best solution).

Agreed, it does not make much sense to invent a new mechanism here. I
guess the default should rather be switched in the the tools that create
the XML for libvirt, i.e. virt-install and friends?

Concerning QEMU, could we maybe simply emit a warning a la

 "you did not specify a machine type with the -M option, so you are
  currently running the the 'pc' machine type. Please note that future
  versions of QEMU might use the 'q35' machine type instead. If you
  require the 'pc' machine type for your setting, then please specify
  it with the -M option."

for a couple of releases, so that other people have a chance to update
their scripts, and then finally switch to q35 ?

 Thomas
