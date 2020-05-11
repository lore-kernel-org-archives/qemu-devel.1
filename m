Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB09AC54E4B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B30206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WKyZx7ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B30206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYEDV-0003sc-JQ
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYE8t-0008Mv-4F
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:31:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1jYE8r-0005O8-8S
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:31:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BJR1vf074690;
 Mon, 11 May 2020 19:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=3MrbEOhSV++RMTzecidcyxKPWr5WbpQdob7iOpE37GE=;
 b=WKyZx7ko6TIsEXWLPXSq+llxE81yEgobK2uzWk5R9INCqKBUCi938bRdQwIZ54B8TBjq
 V+vdfClRSyX+ErYutXLWJTb0Lo26ZMeekPw6V0WYOx3IbqYMtUggdKuLZ6D7vVrgE75y
 0gxFUfqSTBYTBTxDBGCqLbN2xFitZ4crjFrQEr9S8b8mN+EJ+R1Kg4vBobm7MV83U9lK
 eFjrlzxyRT8o8sSF3zt8YUVlWaECAl1jtAPb5QwWGM4c8e8NjAEKvwzNcqgkawz9IwG9
 NYAX1xk5Z6+49R314YmWy6mq8EPc5540csXpvo7LjB7gU+IRt068s5YDjfSUOZm0FOML hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 30x3mbq2tj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 May 2020 19:30:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BJRZQZ036721;
 Mon, 11 May 2020 19:30:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 30x63na0jc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2020 19:30:56 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04BJUrIE017701;
 Mon, 11 May 2020 19:30:53 GMT
Received: from dhcp-10-39-215-151.vpn.oracle.com (/10.39.215.151)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 11 May 2020 12:30:53 -0700
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH RESEND v6 00/36] Initial support for multi-process qemu
From: Jag Raman <jag.raman@oracle.com>
In-Reply-To: <20200511144005.GC182627@stefanha-x1.localdomain>
Date: Mon, 11 May 2020 15:30:50 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D3D00E3-EFE0-4D60-8B68-9CF41F6154CA@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
 <20200511144005.GC182627@stefanha-x1.localdomain>
To: Stefan Hajnoczi <stefanha@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 suspectscore=3
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=3 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110148
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 15:31:06
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, fam@euphon.net,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 thanos.makatos@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On May 11, 2020, at 10:40 AM, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>=20
> Hi,
> Have you decided whether to drop the remote device program in favor of
> using a softmmu make target?
>=20
> Is there anything in this series you'd like me to review before you =
send
> the next revision?

Hi Stefan,

We are planning to drop the separate remote device program in the next
revision. We are planning to use QEMU=E2=80=99s existing event loop =
instead of
a separate event loop for the remote process, as well as the command
line invocation you suggested in your feedback.

We hope the following core patches look good to you, by and large:
[PATCH RESEND v6 01/36] memory: alloc RAM from file at offset
[PATCH RESEND v6 11/36] multi-process: define mpqemu-link object
[PATCH RESEND v6 12/36] multi-process: add functions to synchronize =
proxy and remote endpoints
[PATCH RESEND v6 13/36] multi-process: setup PCI host bridge for remote =
device
[PATCH RESEND v6 14/36] multi-process: setup a machine object for remote =
device process
[PATCH RESEND v6 15/36] multi-process: setup memory manager for remote =
device
[PATCH RESEND v6 17/36] multi-process: introduce proxy object
[PATCH RESEND v6 18/36] multi-process: Initialize Proxy Object's =
communication channel
[PATCH RESEND v6 19/36] multi-process: Connect Proxy Object with device =
in the remote process
[PATCH RESEND v6 20/36] multi-process: Forward PCI config space acceses =
to the remote process
[PATCH RESEND v6 21/36] multi-process: PCI BAR read/write handling for =
proxy & remote endpoints
[PATCH RESEND v6 22/36] multi-process: Synchronize remote memory
[PATCH RESEND v6 23/36] multi-process: create IOHUB object to handle irq
[PATCH RESEND v6 24/36] multi-process: Retrieve PCI info from remote =
process

Thank you very much!
=E2=80=94
Jag

>=20
> Stefan


