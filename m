Received: from eggs.gnu.org ([2001:4830:134:3::10]:39406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvIll-0004G0-OT
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvIlk-00034d-Gf
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:53:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dvIlk-00034K-9z
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:53:04 -0400
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
	<20170921185028.GK21016@localhost.localdomain>
	<20170922093824.58a83358.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f904821b-eeae-5d58-2130-b49483f08021@redhat.com>
Date: Fri, 22 Sep 2017 09:52:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170922093824.58a83358.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel@redhat.com>

On 22.09.2017 09:38, Cornelia Huck wrote:
> On Thu, 21 Sep 2017 15:50:28 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
>> On Tue, Sep 19, 2017 at 10:55:53AM +0200, Thomas Huth wrote:
>>> Historically we've marked all devices as hotpluggable by default. However,
>>> most devices are not hotpluggable, and you also need a HotplugHandler to
>>> support these devices. So if the user tries to "device_add" or "device_del"
>>> such a non-hotpluggable device during runtime, either nothing really usable
>>> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
>>> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
>>> So let's change this dangerous default behaviour and mark the devices as
>>> non-hotpluggable by default. Certain parent devices classes which are known
>>> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
>>> so that devices that are derived from these classes continue to work as
>>> expected.  
>>
>> These seem to be missing:
>> * TYPE_CPU (or at least TYPE_X86_CPU and TYPE_S390_CPU)
> 
> I think it would be better to set it for TYPE_CPU (and have
> architectures override if needed).

Hmm, no, I think TYPE_CPU should stay non-notpluggable, and we should
only do this for TYPE_X86_CPU, TYPE_S390_CPU and TYPE_SPAPR_CPU_CORE.
Most CPU types are not hot-pluggable, so that should be the default.
Having seen all those "device_add" crashes in the past weeks, I'm afraid
that we'll run into weird problems again otherwise since people will
keep forgetting to add "hotpluggable = false" for new CPU types that are
not hotpluggable.

 Thomas
