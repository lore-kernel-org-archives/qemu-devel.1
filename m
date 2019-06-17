Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A662C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73B82084B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IQL79PSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73B82084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcxem-0007Hv-Vf
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55582)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcxcS-0006FM-Kb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcxcR-0004wg-0y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:48:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36912)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcxcP-0004E8-FV
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 15:48:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HJTlFT017447;
 Mon, 17 Jun 2019 19:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=56Ex+uYGZCHkCUTdbDBmuyw+IX+onTJrNO19hlLRGrU=;
 b=IQL79PSlaIkY2hq675ShzqYzsrWfmtiw0vzkTMhHyqH4GLEyUTSgEPzPlUWE8Nld0fzE
 gkUQZqP++R5K42G0m9tzbNHMrG7fwTbEQdYoRCSWl4BazgBhX4V8DFRvcq0+Sq7X637E
 0JWWJeqEdx07epdAOurdaPejhhKedbDXIDoRbnW3sD3Z1MyMFckkiz6FMOmM2NY79cy6
 NrCTVVDQpCipcm+8NqIMN2Jn6Utrp6Mjb9lUtqWiGh3AlB6pQWuiQBM8ZfRJW7StYu59
 iO9vdYeeh23gBF+af49apSOyqmr4B7d65X4THkXFuyMPa6f3Ie2SB5fAF6Z25N8qKHU6 bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2t4r3tgftj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 19:47:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HJl9U5111370;
 Mon, 17 Jun 2019 19:47:43 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2t5h5tb1tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 19:47:43 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HJlgig020543;
 Mon, 17 Jun 2019 19:47:42 GMT
Received: from heatpipe (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 12:47:42 -0700
Date: Mon, 17 Jun 2019 12:47:39 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190617194739.GB24278@heatpipe>
References: <20190617181631.30233-1-elena.ufimtseva@oracle.com>
 <c8e6cb54-4b37-1452-c215-a9e071000635@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e6cb54-4b37-1452-c215-a9e071000635@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170172
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170172
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: Re: [Qemu-devel] [RFC PATCH v2 24/35] multi-process: add
 qdev_proxy_add to create proxy devices
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
Cc: john.g.johnson@oracle.com, jag.raman@oracle.com, konrad.wilk@oracle.com,
 qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com,
 kanth.ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 02:22:08PM -0500, Eric Blake wrote:
> On 6/17/19 1:16 PM, elena.ufimtseva@oracle.com wrote:
> > From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > 
> > This is handled while parsing the command line options.
> > The parsed options are being sent to remote process
> > as the messgaes containing JSON strings.
> 
> s/messgaes/messages/
> 
> > 
> > Changes in v2:
> >  - parse socket and command suboptions of drive/device commands;
> 
> The changelog paragraph belongs...
> 
> > 
> > Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> > Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> > Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> > ---
> 
> ...here, after the --- divider. It is useful to reviewers, but gets
> stripped by 'git am' when the maintainer applies the series. A year from
> now, we won't care how many iterations the patches went through on list,
> only the one version that got committed to git.
>

That one slipped trough with this, will fix.

> >  include/hw/proxy/qemu-proxy.h |   7 ++
> >  include/monitor/qdev.h        |   5 +
> >  qdev-monitor.c                | 166 ++++++++++++++++++++++++++++++++++
> >  3 files changed, 178 insertions(+)
> > 
> 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 




