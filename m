Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654F4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3095720679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgJgNgR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3095720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN5EO-00052q-9t
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 21:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN5Db-0004Sb-9X
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN5Da-0006J0-BW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:13:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN5Da-0006Hg-8J
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571793221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1O0uPkSjaiBSnewfPYGEvo+0gVJer3elYoUv0JUWjoQ=;
 b=LgJgNgR3PWGKhMjxDSDf82PsawsNNgVww2+11exborWXeWmIPxZa+fwtp51RsBKD0YS+or
 IKV5QR3DmzNH8204Wc0tMSeAzWwCzSeBpBvnxokad1/AS1E0j180R+o7u56yWmq19RMED/
 bfgQZ35rQHGmXSvEIl1zRMnJSZR0Jpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-AwoFuPObOEqByoLT-OASOA-1; Tue, 22 Oct 2019 21:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E4541005500;
 Wed, 23 Oct 2019 01:13:36 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A96A860C57;
 Wed, 23 Oct 2019 01:13:35 +0000 (UTC)
Subject: Re: [PATCH v13 01/12] util/cutils: Add qemu_strtotime_ps()
To: Tao Xu <tao3.xu@intel.com>, imammedo@redhat.com, ehabkost@redhat.com
References: <20191020111125.27659-1-tao3.xu@intel.com>
 <20191020111125.27659-2-tao3.xu@intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7a0662f5-28e3-4bb8-0b20-669d34cf56a6@redhat.com>
Date: Tue, 22 Oct 2019 20:13:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191020111125.27659-2-tao3.xu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AwoFuPObOEqByoLT-OASOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jingqi.liu@intel.com, fan.du@intel.com, qemu-devel@nongnu.org,
 jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 6:11 AM, Tao Xu wrote:
> To convert strings with time suffixes to numbers, support time unit are
> "ps" for picosecond, "ns" for nanosecond, "us" for microsecond, "ms"
> for millisecond or "s" for second.

I haven't yet reviewed the patch itself, but my off-hand observation:

picosecond is probably too narrow to ever be useful.  POSIX interfaces=20
only go down to nanoseconds, and when you start adding in vmexit delay=20
times and such, we're lucky when we get anything better than microsecond=20
accuracies.  Supporting just three sub-second suffixes instead of four=20
would slightly simplify the code, and not cost you any real precision.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


