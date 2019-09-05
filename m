Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3FDC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E7220820
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LcXFv5g+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E7220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5td1-0003Jj-TE
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5tZS-0007tb-1I
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5tZQ-0007Kh-Gw
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5tZQ-0007KA-8g
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:21:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FBhLj061264;
 Thu, 5 Sep 2019 15:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=eNTqatkW14IZZGl/IgpHyYDiV9rlWkgLtC82tS4kvKo=;
 b=LcXFv5g+xSCViRcV2LJnabV8Jl7lWTQ64NqnU5l+9OyWgkt4Vj7l+Bdye49TGMgg7VhI
 Mr++iuewtDstQUHyz60glRic+ePvcp4LxcxBoxf8IrtEOcdx+WSDHFYLj213+eutr0JQ
 NE7ByVPVQCncpdVzi9FKbEjhXcyKWWOwZbqHrNqdBfyh5FShh+gU5s/iVW2Qr7F/FAuf
 kuj2VCNxrlqixAsRzNLhp87Kev2qdxTKEtWmLnmEDsaaOVvAQX/rnuHcV+cjI2Le0PK4
 EJ72Y5v/od54130UaA6FAQYKfkII9XPEddnNYWF8VUetCuDs3Z0xJHM613fxlk4BfJfO EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2uu4sb8291-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:21:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x85FBE0M141512;
 Thu, 5 Sep 2019 15:20:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 2uthq1uqyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 05 Sep 2019 15:20:59 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x85FKuKa017073;
 Thu, 5 Sep 2019 15:20:56 GMT
Received: from [10.152.34.2] (/10.152.34.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 05 Sep 2019 08:20:56 -0700
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <51220007b0f8a34cc72ff2847f5deb1f85c9c0e4.1567534653.git.jag.raman@oracle.com>
 <20190904082258.GC19582@redhat.com>
 <7b558814-d17e-e135-ee0f-e92632545d93@redhat.com>
From: Jag Raman <jag.raman@oracle.com>
Organization: Oracle Corporation
Message-ID: <7eab8e47-0d95-9062-9eb7-347b52d24279@oracle.com>
Date: Thu, 5 Sep 2019 11:20:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <7b558814-d17e-e135-ee0f-e92632545d93@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909050144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9371
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909050144
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 x85FBhLj061264
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: Re: [Qemu-devel] [RFC v3 PATCH 07/45] multi-process: define
 proxy-link object
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, thuth@redhat.com,
 john.g.johnson@oracle.com, ehabkost@redhat.com, konrad.wilk@oracle.com,
 quintela@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 ross.lagerwall@citrix.com, mreitz@redhat.com, kanth.ghatraju@oracle.com,
 kraxel@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 liran.alon@oracle.com, marcandre.lureau@gmail.com, kwolf@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/5/2019 10:37 AM, Eric Blake wrote:
> On 9/4/19 3:22 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Sep 03, 2019 at 04:37:33PM -0400, Jagannathan Raman wrote:
>>> Defines proxy-link object which forms the communication link between
>>> QEMU & emulation program.
>>> Adds functions to configure members of proxy-link object instance.
>>> Adds functions to send and receive messages over the communication
>>> channel.
>>> Adds GMainLoop to handle events received on the communication channel.
>=20
>>> +
>>> +#ifndef PROXY_LINK_H
>>> +#define PROXY_LINK_H
>>> +
>>> +#include <stddef.h>
>>> +#include <stdint.h>
>>> +#include <glib.h>
>>
>> I'm guessing this is the cause - nothing should be including this
>> directly - it is pulled  in for you via qemu/osdep.h
>>
>>> +#include <pthread.h>
>>> +
>>> +#include "qemu/osdep.h"
>=20
> For that matter, "qemu/osdep.h" should ALWAYS be listed first, before
> any system headers, and inclusion of <stddef.h> and <stdint.h> is also
> redundant, just as the <glib.h>.

Removing <glib.h> resolved the build issue. We'll remove <glib.h> in all
files in the next rev.

We soon realized the "qemu/osdep.h" should be the first include in all
the files. We'll ensure that this is the case for all files in the next
revision.

Thanks!
--
Jag

>=20
>=20

