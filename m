Received: from eggs.gnu.org ([2001:4830:134:3::10]:52124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff1lx-0004RL-EY
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ff1lw-00039t-J1
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 07:34:33 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-7-git-send-email-thuth@redhat.com>
	<d76b1a42-e232-f8a3-48dc-d71238403c94@redhat.com>
	<49dcf89e-6f5a-7497-e5fd-e54d4fcd59eb@redhat.com>
	<9133dc89-5f24-0802-caa6-bf73b2c229d1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51cb2845-f23d-4f0a-eaa1-d4e96a6764d4@redhat.com>
Date: Mon, 16 Jul 2018 13:34:24 +0200
MIME-Version: 1.0
In-Reply-To: <9133dc89-5f24-0802-caa6-bf73b2c229d1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/16] hw/display/xlnx_dp: Move
 problematic code from instance_init to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Markus Armbruster <armbru@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 13.07.2018 19:13, Paolo Bonzini wrote:
> On 13/07/2018 17:59, Thomas Huth wrote:
>> Your patch looks good at a first quick glance, but it seems not to work as expected: When I now run QEMU like this:
>>
>> echo "{'execute':'qmp_capabilities'}" \
>>  "{'execute':'device-list-properties'," \
>>  "'arguments':{'typename':'xlnx,zynqmp'}}" \
>>  "{'execute': 'human-monitor-command', " \
>>  "'arguments': {'command-line': 'info qtree'}}" | \
>>  aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
>>
>> then QEMU ends up in an endless loop and I've got to kill it.
> 
> There are two more bugs that my patch makes un-latent, where the
> objects are created but not added as children.  Therefore when
> you call object_unparent on them, nothing happens.
> 
> In particular dpcd and edid give you an infinite loop in bus_unparent,
> because device_unparent is not called and does not remove them from
> the list of devices on the bus.
> 
> The following incremental changes fix everything for me.  Note that
> aux_create_slave/qdev_create already do the unref for you.

Thanks, that fixes the problem, indeed. I'll squash this into your patch
and send out a v3 series.

 Thomas
