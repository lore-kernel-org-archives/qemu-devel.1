Received: from eggs.gnu.org ([2001:4830:134:3::10]:40831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwmkf-0008Jb-St
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:06:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwmka-0003ev-7G
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:06:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwmka-0003eW-0O
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 06:06:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 847DFC047B7F
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:05:58 +0000 (UTC)
References: <1504776162-31400-1-git-send-email-thuth@redhat.com>
	<20170921175650.GJ21016@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1983cfd3-557a-c7ff-6fab-446efa6cf5d4@redhat.com>
Date: Tue, 26 Sep 2017 12:05:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170921175650.GJ21016@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/qdev: Do not allow hot-plugging
 without hotplug controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 21.09.2017 19:56, Eduardo Habkost wrote:
> On Thu, Sep 07, 2017 at 11:22:42AM +0200, Thomas Huth wrote:
>> qdev_unplug() bails out with an assertion if the user tries to device_del
>> a hot-plugged device that does not have a hotplug controller. Unfortunately,
>> our devices are all marked with hotpluggable = true by default (see the
>> device_class_init() function in qdev.c), so it currently can happen that
>> the user runs into this situation and QEMU gets terminated unexpectedly:
>>
>> $ qemu-system-aarch64 -M virt -nographic -nodefaults -monitor stdio -S
>> QEMU 2.10.50 monitor - type 'help' for more information
>> (qemu) device_add aux-to-i2c-bridge,id=x
>> (qemu) device_del x
>> **
>> ERROR:qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctrl)
>> Aborted (core dumped)
>>
>> Hotplugging devices without a hotplug controller does not make much sense,
>> so we should disallow this during the device_add process already!
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> I'm queueing this on machine-next.  We still want it even if we
> apply the patch that changes TYPE_DEVICE to hotpluggable=false by
> default, right?

OK, just to be sure: Please de-queue it again. As you already mentioned
in another mail, there are situations where this does not work (e.g.
when one hot-pluggable device wants to instantiate another hot-pluggable
device internally).

But maybe we could add the test for the availability of a hot-plug
controller to qmp_device_add() instead? (I haven't had a closer look at
that yet, though).

 Thomas
