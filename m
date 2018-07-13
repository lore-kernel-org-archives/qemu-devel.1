Received: from eggs.gnu.org ([2001:4830:134:3::10]:57254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fe0U1-0006rl-IK
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fe0U0-0006Q9-MH
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 11:59:49 -0400
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-7-git-send-email-thuth@redhat.com>
	<d76b1a42-e232-f8a3-48dc-d71238403c94@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <49dcf89e-6f5a-7497-e5fd-e54d4fcd59eb@redhat.com>
Date: Fri, 13 Jul 2018 17:59:37 +0200
MIME-Version: 1.0
In-Reply-To: <d76b1a42-e232-f8a3-48dc-d71238403c94@redhat.com>
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
Cc: qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>

On 13.07.2018 13:13, Paolo Bonzini wrote:
> On 13/07/2018 10:27, Thomas Huth wrote:
>> aux_create_slave() calls qdev_init_nofail() which in turn "realizes"
>> the corresponding object. Thus this most not be called from an
>> instance_init function. Move the code to the realize function instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/display/xlnx_dp.c | 23 +++++++++--------------
>>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
>> +    s->aux_bus = aux_init_bus(dev, "aux");
> 
> aux_init_bus can remain in the same place, and likewise the qdev_create
> that assigns to s->edid.
> 
> The only thing that has to move is the qdev_init_nofail and
> aux_bus_map_device, like this:
> 
> ----------------- 8< ------------------
> From: Paolo Bonzini <pbonzinI@redhat.com>
> Subject: [PATCH] hw/display/xlnx_dp: Move problematic code from instance_init to realize

Your patch looks good at a first quick glance, but it seems not to work as expected: When I now run QEMU like this:

echo "{'execute':'qmp_capabilities'}" \
 "{'execute':'device-list-properties'," \
 "'arguments':{'typename':'xlnx,zynqmp'}}" \
 "{'execute': 'human-monitor-command', " \
 "'arguments': {'command-line': 'info qtree'}}" | \
 aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio

then QEMU ends up in an endless loop and I've got to kill it.

 Thomas
