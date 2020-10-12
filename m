Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF37C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 02:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9129B20757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 02:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwrs/jPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9129B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRo1v-0002QK-90
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 22:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kRo11-0001zY-Q7
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 22:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kRo0y-0005S1-4I
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 22:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602471401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OoJmvJjEIQ9uKE2EVMnMh55DvhuNBQBgDD00b/OzaYM=;
 b=iwrs/jPudOAwQxBJaa93BeGXtTKi90AmztQtdOg2DstXsWdjX3T704DDUn9IZh6Is4J3kZ
 ygQvk2kXJ7CwgYK9yKdJjnZYDoiMJXYcjAPq/cP5ipzQjgzsRMeCrVfztZguckYsCeEl8X
 lS+LwONJFGcqP6DY98tsNITfo+VaPPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ACi833VvOwmZPd8SWFXLeA-1; Sun, 11 Oct 2020 22:56:39 -0400
X-MC-Unique: ACi833VvOwmZPd8SWFXLeA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 424121868400;
 Mon, 12 Oct 2020 02:56:38 +0000 (UTC)
Received: from [10.72.13.74] (ovpn-13-74.pek2.redhat.com [10.72.13.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D79CB27CC5;
 Mon, 12 Oct 2020 02:56:15 +0000 (UTC)
Subject: Re: Outline for VHOST_USER_PROTOCOL_F_VDPA
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20200928092537.GA44353@stefanha-x1.localdomain>
 <CAMxuvayJXbSVAG3yJPkb+_9OU5k623WKOksEpHjVU5eV9U=zKA@mail.gmail.com>
 <20200928153257.GA173977@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d140fcd1-8a3f-ed24-1ef0-82b4c68746e8@redhat.com>
Date: Mon, 12 Oct 2020 10:56:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200928153257.GA173977@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 21:16:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lulu@redhat.com, tiwei.bie@intel.com, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, "Coquelin,
 Maxime" <maxime.coquelin@redhat.com>, "Hoffmann, Gerd" <kraxel@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, Nikos Dragazis <ndragazis@arrikto.com>,
 "Liu, Changpeng" <changpeng.liu@intel.com>, Daniele Buono <dbuono@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/9/28 下午11:32, Stefan Hajnoczi wrote:
> On Mon, Sep 28, 2020 at 03:21:56PM +0400, Marc-André Lureau wrote:
>> On Mon, Sep 28, 2020 at 1:25 PM Stefan Hajnoczi <stefanha@redhat.com wrote:
>>> Where this converges with multi-process QEMU
>>> --------------------------------------------
>>> At this point QEMU can run ad-hoc vhost-user backends using existing
>>> VIRTIO device models. It is possible to go further by creating a
>>> qemu-dev launcher executable that implements the vhost-user spec's
>>> "Backend program conventions". This way a minimal device emulator
>>> executable hosts the device instead of a full system emulator.
>>>
>>> The requirements for this are similar to the multi-process QEMU effort,
>>> which aims to run QEMU devices as separate processes. One of the main
>>> open questions is how to design build system and Kconfig support for
>>> building minimal device emulator executables.
>>>
>>> In the case of vhost-user-net the qemu-dev-vhost-user-net executable
>>> would contain virtio-net-device, vhost-user-backend, any netdevs the
>>> user wishes to include, a QMP monitor, and a vhost-user backend
>>> command-line interface.
>>>
>>> Where does this leave us? QEMU's existing VIRTIO device models can be
>>> used as vhost-user devices and run in a separate processes from the VMM.
>>> It's a great way of reusing code and having the flexibility to deploy it
>>> in the way that makes most sense for the intended use case.
>>>
>> My understanding is that this would only be able to expose virtio
>> devices from external processes. But vfio-user could expose more kinds
>> of devices, including the virtio devices.
>>
>> Shouldn't we focus on vfio-user now, as the general out-of-process
>> device solution?


Similar question could be asked for vDPA(kernel) vs VFIO(kernel).


> Eventually vfio-user can replace vhost-user. However, vfio-user
> development will take longer so for anyone already comfortable with
> vhost-user I think extending the protocol with vDPA ioctls is
> attractive.


My understanding is for vhost-user may advantages:

- well defined interface, this helps a lot for e.g live migration (cross 
migration among different vendors), backend disconnection, device 
failover and there will be no vendor lock
- high level abstraction, not tie to a specific bus implementation, 
micro VM that want to get rid of PCI can use MMIO transport

So it doesn't conflict with vfio(-user) which is more suitable for any 
vendor specific device (API)s.

Thanks


>
> Maybe we can get more organized around vfio-user and make progress
> quicker?
>
> Stefan


