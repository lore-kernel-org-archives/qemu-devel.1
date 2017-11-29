Received: from eggs.gnu.org ([2001:4830:134:3::10]:47730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eJro4-0004E4-VM
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eJrnz-0003GN-VM
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:09:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eJrnz-0003Fv-Pb
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 21:08:55 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF7A780F7A
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 02:08:54 +0000 (UTC)
References: <20171128133123.17372-1-vkaplans@redhat.com>
	<20171128195847-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <524d5839-3cf8-106f-f4b5-04dadd14e35a@redhat.com>
Date: Wed, 29 Nov 2017 10:08:46 +0800
MIME-Version: 1.0
In-Reply-To: <20171128195847-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user spec: Clarify policy on setting
 log_base
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Victor Kaplansky <vkaplans@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, qemu-devel@nongnu.org



On 2017=E5=B9=B411=E6=9C=8829=E6=97=A5 02:06, Michael S. Tsirkin wrote:
> On Tue, Nov 28, 2017 at 03:46:44PM +0200, Victor Kaplansky wrote:
>> From: Victor Kaplansky<vkaplans@dell9020.localdomain>
>>
>> If we allow qemu to change logging area after it was already establish=
ed,
>> it may require from the backend to acquire a lock on each access to
>> the log_base, which has a potential quite a big performance hit.
>>
>> Thus we would like to clarify in the spec, that qemu is not expected
>> to resize or remap the logging area, and backend implementations
>> can safely ignore subsequent requests to log_base modifications.
>>
>> Signed-off-by: Victor Kaplansky<vkaplans@redhat.com>
>> Suggested-by: Maxime Coquelin<maxime.coquelin@redhat.com>
> I'm not sure we can do this.
>
>
> Log resizing as a result of memory hotplug might force
> log base changes.
>
> Backends need to use something like
> rcu to avoid need for locking.
>
> Apropos I wonder whether it's a bug that vhost_dev_start
> calls vhost_set_log_base after starting rings.
>
> Same question for the iotlb callback.

At least for kernel vhost-net, it doesn't since the backend won't start=20
to work until SET_BACKEND which is done in vhost_net_start_one() after=20
vhost_dev_start().

Thanks
