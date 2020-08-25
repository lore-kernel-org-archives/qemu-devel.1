Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856A220786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyxIZ4Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856A220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAasp-0006p6-J2
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAasC-0006Nj-IR
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:28:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27335
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kAasB-000744-0d
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598369309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nx2K/wQnUK12SualFHAXyVQtV8puTCcnLGAdUTH+A9c=;
 b=gyxIZ4Dgij0ob1ar5fJft1+q8zE8f6mKQV5nIr7bL5SAv3mn3wdP1b3Aveultk4L+e06kc
 iqqRblwuBwgsP1s3U4twSHVPPczeM0vxYYoujT0o2wO6LuijogNGix69o4u+AeqX5fV3Nc
 jKYx+fkElw2J2atH0Mvt5/ale2vitXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-5zF11UgXMY2eClJDFulN_Q-1; Tue, 25 Aug 2020 11:28:27 -0400
X-MC-Unique: 5zF11UgXMY2eClJDFulN_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C22189E606;
 Tue, 25 Aug 2020 15:28:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-74.ams2.redhat.com
 [10.36.112.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E543D19C58;
 Tue, 25 Aug 2020 15:28:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71C52112D737; Tue, 25 Aug 2020 17:28:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v4 6/6] block/fileb: switch to use qemu_open/qemu_create
 for improved errors
References: <20200821172105.608752-1-berrange@redhat.com>
 <20200821172105.608752-7-berrange@redhat.com>
Date: Tue, 25 Aug 2020 17:28:24 +0200
In-Reply-To: <20200821172105.608752-7-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Fri, 21 Aug 2020 18:21:05
 +0100")
Message-ID: <878se2bv8n.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:36:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Currently at startup if using cache=3Dnone on a filesystem lacking
> O_DIRECT such as tmpfs, at startup QEMU prints
>
> qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: file system =
may not support O_DIRECT
> qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: Could not op=
en '/tmp/foo.img': Invalid argument
>
> while at QMP level the hint is missing, so QEMU reports just
>
>   "error": {
>       "class": "GenericError",
>       "desc": "Could not open '/tmp/foo.img': Invalid argument"
>   }
>
> which is close to useless for the end user trying to figure out what
> they did wrong.
>
> With this change at startup QEMU prints
>
> qemu-system-x86_64: -drive file=3D/tmp/foo.img,cache=3Dnone: Unable to op=
en '/tmp/foo.img' flags 0x4000: filesystem does not support O_DIRECT
>
> while at the QMP level QEMU reports a massively more informative
>
>   "error": {
>      "class": "GenericError",
>      "desc": "Unable to open '/tmp/foo.img' flags 0x4002: filesystem does=
 not support O_DIRECT"
>   }
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Both commit message and expected iotest results demonstrate the less
than helpful flags error reporting I pointed out in my review of PATCH
3.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


