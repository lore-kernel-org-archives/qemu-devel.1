Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E1C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E653E238A1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzZbquvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E653E238A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUwN-0004jQ-M6
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kLUty-0003XF-Kl
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:19:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1kLUtv-0006Zt-87
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 13:19:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OHDYMU192254;
 Thu, 24 Sep 2020 17:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=gdOO8htUaY10FaqVP3jvCbbUBnASy1+dXFaImoIjwaQ=;
 b=nzZbquvUy9nl4dTxEfuaFzxzqlj/OMOfpPf6L0V7Rxm7gFJjpHO2tX5KacUoVjzR3Mcz
 LCoWNXoucXt5CmM0tgpCiSoLXadUF4E1RAk9OaW0T3OVnbSbXv1+YC5ai8VlsoSXZGeP
 DHSHq5if39vDcd8fnR74HUU3vJkIvmSe18tbrrr1gxWx5SeNqsu9bF1gaL6monQCmybK
 b5nTUVYw8Gm9H3bjqBtLaxsye3bf41XSoQH0xl0s17lJOUtJfZQZXjPoifi3l8ZjJtzN
 W9vM6TLIhzTEvcMlDamiJYm3YiLwuq/titmY/ti17cx6b4R7Lwhbllxl60jRiNEgwQK3 wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 33qcpu6gnv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Sep 2020 17:18:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08OHEBH0016809;
 Thu, 24 Sep 2020 17:18:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 33r28x8xtq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2020 17:18:56 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08OHIr7J014402;
 Thu, 24 Sep 2020 17:18:53 GMT
Received: from flaka (/67.180.143.163) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Sep 2020 10:18:52 -0700
Date: Thu, 24 Sep 2020 10:18:49 -0700
From: Elena Ufimtseva <elena.ufimtseva@oracle.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v9 07/20] multi-process: define transmission functions in
 remote
Message-ID: <20200924171849.GA11701@flaka>
References: <20200827181231.22778-1-elena.ufimtseva@oracle.com>
 <20200827181231.22778-8-elena.ufimtseva@oracle.com>
 <20200923140246.GB62770@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923140246.GB62770@stefanha-x1.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754
 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240127
Received-SPF: pass client-ip=141.146.126.79;
 envelope-from=elena.ufimtseva@oracle.com; helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 13:19:20
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, swapnil.ingle@nutanix.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 03:02:46PM +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 27, 2020 at 11:12:18AM -0700, elena.ufimtseva@oracle.com wrote:
> > TODO: Avoid the aio_poll by entering the co-routines
> > from the higher level to avoid aio_poll.
> 
> The monitor is unresponsive during the aio_poll() loop. Is this a
> blocker for you?
>
Hi Stefan
No, not a blocker, had to leave out removal of aio_poll for the next round.
 
> Running all mpqemu communication in a coroutine as mentioned in this
> TODO is a cleaner solution. Then this patch will be unnecessary.
>
Yes, thank you, it will go away in v10.

> > +static void coroutine_fn mpqemu_msg_send_co(void *data)
> > +{
> > +    MPQemuRequest *req = (MPQemuRequest *)data;
> > +    Error *local_err = NULL;
> > +
> > +    mpqemu_msg_send(req->msg, req->ioc, &local_err);
> > +    if (local_err) {
> > +        error_report("ERROR: failed to send command to remote %d, ",
> > +                     req->msg->cmd);
> > +        req->finished = true;
> > +        req->error = -EINVAL;
> > +        return;
> 
> local_err is leaked.
> 
> > +    }
> > +
> > +    req->finished = true;
> > +}
> > +
> > +void mpqemu_msg_send_in_co(MPQemuRequest *req, QIOChannel *ioc,
> > +                                  Error **errp)
> > +{
> > +    Coroutine *co;
> > +
> > +    if (!req->ioc) {
> > +        if (errp) {
> > +            error_setg(errp, "Channel is set to NULL");
> > +        } else {
> > +            error_report("Channel is set to NULL");
> > +        }
> 
> The caller should provide an errp if they are interested in the error
> message. Duplicating error messages is messy.
> 
> > +static void coroutine_fn mpqemu_msg_recv_co(void *data)
> > +{
> > +    MPQemuRequest *req = (MPQemuRequest *)data;
> > +    Error *local_err = NULL;
> > +
> > +    mpqemu_msg_recv(req->msg, req->ioc, &local_err);
> > +    if (local_err) {
> > +        error_report("ERROR: failed to send command to remote %d, ",
> > +                     req->msg->cmd);
> > +        req->finished = true;
> > +        req->error = -EINVAL;
> > +        return;
> 
> local_err is leaked.

Thank you for reviewing these, will fix If the code above will be re-used.

Elena


