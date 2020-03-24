Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C21DC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB3B20724
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 05:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHDS3DDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB3B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGcSV-0002nv-0u
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 01:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jGcRt-0002P2-D0
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:50:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jGcRs-00071l-6z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:50:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jGcRs-00071f-3V
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 01:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585028999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gP/kC2IKX4TrVi2p7r7supKDWbQx50G9dVQeZoPAe4=;
 b=iHDS3DDq2JwJfMFs3JqMSYCUi8UUAFJv+81tB46XRCTtSQ9afbK1py6yPUrJD4ohq7sYHp
 Q/VXp4riD88PWm15r9Zx0wL+FWLJ9NfsYcjnzNxiIp4A8OVdRt6A3zYcQXe0PMbhjxPTmU
 wN/YAGz4g6GjKmcuJ0SlP8b1/fdOelA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-OBD7rWfHMuuudO3stUX0NA-1; Tue, 24 Mar 2020 01:49:58 -0400
X-MC-Unique: OBD7rWfHMuuudO3stUX0NA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F37E28017CC;
 Tue, 24 Mar 2020 05:49:56 +0000 (UTC)
Received: from [10.72.13.216] (ovpn-13-216.pek2.redhat.com [10.72.13.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D79510016EB;
 Tue, 24 Mar 2020 05:49:55 +0000 (UTC)
Subject: Re: [question]vhost-user: atuo fix network link broken during
 migration
To: "yangke (J)" <yangke27@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <0CC1E03725E48D478F815032182740230A42A312@DGGEMM532-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <47abadbd-c559-1900-f3b1-3697f9e7c0b5@redhat.com>
Date: Tue, 24 Mar 2020 13:49:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0CC1E03725E48D478F815032182740230A42A312@DGGEMM532-MBS.china.huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "wangxin \(U\)" <wangxinxin.wang@huawei.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/23 =E4=B8=8B=E5=8D=884:17, yangke (J) wrote:
> We find an issue when host mce trigger openvswitch(dpdk) restart in sourc=
e host during guest migration,


Did you mean the vhost-user netev was deleted from the source host?


> VM is still link down in frontend after migration, it cause the network i=
n VM never be up again.
>
> virtio_net_load_device:
>      /* nc.link_down can't be migrated, so infer link_down according
>       * to link status bit in n->status */
>      link_down =3D (n->status & VIRTIO_NET_S_LINK_UP) =3D=3D 0;
>      for (i =3D 0; i < n->max_queues; i++) {
>          qemu_get_subqueue(n->nic, i)->link_down =3D link_down;
>      }
>
> guset:                    migrate begin -------> vCPU pause --------> vms=
ate load ------->migrate finish
>                                              ^                  ^        =
             ^
>                                              |                  |        =
             |
> openvswitch in source host:          begin to restart       restarting   =
          started
>                                              ^                  ^        =
             ^
>                                              |                  |        =
             |
> nc in frontend in source:               link down           link down    =
         link down
>                                              ^                  ^        =
             ^
>                                              |                  |        =
             |
> nc in frontend in destination:          link up             link up      =
         link down
>                                              ^                  ^        =
             ^
>                                              |                  |        =
             |
> guset network:                            broken             broken      =
          broken
>                                              ^                  ^        =
             ^
>                                              |                  |        =
             |
> nc in backend in source:                link down          link down     =
         link up
>                                              ^                  ^        =
             ^
>                                              |                  |        =
             |
> nc in backend in destination:           link up             link up      =
         link up
>
> The link_down of frontend was loaded from n->status, n->status is link do=
wn in source, so the link_down of
> frontend is true. The backend in destination host is link up, but the fro=
ntend in destination host is
> link down, it cause the network in gust never be up again until an guest =
cold reboot.
>
> Is there a way to auto fix the link status? or just abort the migration i=
n virtio net device load?


Maybe we can try to sync link status after migration?

Thanks



