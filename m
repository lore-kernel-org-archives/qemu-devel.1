Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1EBC35280
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:55:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CF9208CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 02:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBYR548H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CF9208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWtAz-0003sK-Pi
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 22:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWtAQ-0003Ls-CL
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:55:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56613
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jWtAP-0003zn-0G
 for qemu-devel@nongnu.org; Thu, 07 May 2020 22:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588906511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXnPkNn6n2GjumaSgJe6SfxJCfZ6byS35b+6u+weD0s=;
 b=cBYR548HLDilUI0Om3weN7nNStZJIjRnZiDOX8qg+qGxYojqGij0RRdDqiAcdqxZu920m+
 Z2VN49BOW+GZ7txMG4I4n027H+uR2aKduvr1TDBjPmbabE+Di07+Vxr8CimHoJkMb9KMoS
 GCFx8y4sErJcg+EWMVLBhjztZ0jaAjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-MY2HozjyNG-Cfv06YJqyqg-1; Thu, 07 May 2020 22:55:09 -0400
X-MC-Unique: MY2HozjyNG-Cfv06YJqyqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 992D618FE863;
 Fri,  8 May 2020 02:55:08 +0000 (UTC)
Received: from [10.72.13.98] (ovpn-13-98.pek2.redhat.com [10.72.13.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10B5F5D9C5;
 Fri,  8 May 2020 02:54:31 +0000 (UTC)
Subject: Re: [RFC v3 3/6] qmp: decode feature bits in virtio-status
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200507114927.6733-1-lvivier@redhat.com>
 <20200507114927.6733-4-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1b4c1915-b5d5-bc2d-9b02-b9483eebbe80@redhat.com>
Date: Fri, 8 May 2020 10:54:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507114927.6733-4-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>,
 Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/5/7 =E4=B8=8B=E5=8D=887:49, Laurent Vivier wrote:
> Display feature names instead of a features bitmap for host, guest
> and backend.
>
> Decode features according device type, transport features are
> on the first line. Undecoded bits (if any) are stored in a separate
> field.
>
> Signed-off-by: Laurent Vivier<lvivier@redhat.com>


This is really useful. I wonder maybe we need something similar in=20
driver side, current sysfs can only display magic binary numbers.

Thanks


