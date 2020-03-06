Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7FAC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3942073D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rhoW7kgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3942073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAErZ-0005rP-N0
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 10:26:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jAEoA-0003ud-UQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:22:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1jAEo9-0005Te-MU
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:22:38 -0500
Received: from mout.web.de ([212.227.15.4]:35739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1jAEo9-0005O8-9y
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 10:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1583508123;
 bh=EHAIwG7fgUe1eM6jy+BvALJJBFFaLuFIk31dT7m4BCc=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=rhoW7kgypQXtq7x36sXaKuH/3cm07FSsexgex7w3M39cQhDFupSErgevowAZUa+qi
 /va7YP3oklZXkZy4od/oNi4wRw/7BON9xqlRj2eHuPH8s5lCNJIhPYwwQQwizJH08l
 KTryIP+r8vDPCRB7kJWOFgqpcpfDDbw8zIQfnJ38=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.242]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M40jS-1jRLwX2xvO-00rVYM; Fri, 06
 Mar 2020 16:22:03 +0100
Date: Fri, 6 Mar 2020 16:22:01 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: The issues about architecture of the COLO checkpoint
Message-ID: <20200306162201.3a1cd3ae@luklap>
In-Reply-To: <343daa37127e424c94fa0a3edde30f0c@intel.com>
References: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
 <20200211174756.GA2798@work-vm>
 <8737854e2826400fa4d14dc408cfd947@huawei.com>
 <2b09c8650b944c908c0c95fefe6d759f@intel.com>
 <CA+XQNE5hn=FJh7cq5YP0ydYEHkap-a-9AXeTLJd=24sQ1DWkwg@mail.gmail.com>
 <1bf96353e8e2490098a71d0d1182986a@huawei.com>
 <51f95ec9ed4a4cc682e63abf1414979b@intel.com>
 <b440cfb28e6c4aa38d79b93ed04a106f@intel.com>
 <CA+XQNE78cE-wMtNZBrXa+HQmuXmRGtjKJr_0JXaYPCEFEhXgwQ@mail.gmail.com>
 <20200213103752.GE2960@work-vm>
 <CA+XQNE7i15fTmwN6UL_fNi1e2sEb5v6+T05FaYdy0nS-DFC9HA@mail.gmail.com>
 <e820e35d-5b8a-18c8-736b-6c38cff9798e@intel.com>
 <CA+XQNE49wq2nRKJ0CA4uHDZ4OUEbFGPKBfAWB4+UwPYgiZkrCw@mail.gmail.com>
 <5d030380-76d6-67c6-39a1-82c197e320b4@intel.com>
 <CA+XQNE6riKARXtP9oZaQjK9Gqgfh-+Ae8qX+WsWhGfMB0hf8tg@mail.gmail.com>
 <0c69b913bf1047c4b7d5edac50f3988b@intel.com>
 <CA+XQNE6tZv0uhGoqqnS2ki=ZjP_YFaE53ZZntKPAbCxGnO1V8A@mail.gmail.com>
 <343daa37127e424c94fa0a3edde30f0c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a7PJZWpZQKtgaxeX6OttYBRKNy/jtE9jUvZMLmmpHZ4z68KP7cN
 tHhHu7fr+iGtqejlY6UnjbptZVND3Yb4Eioaa59/Q8fJ6lna8g98Ssjjr+jkojgpTAeWj56
 GXXyfYku6Vdx8rG5aEYIIZdG5+Rlpuenmq17/Hnd75Vhwzufr9EQz53Xvu8t78byQwLrQD+
 P4zx/uxN+2lWYiHTNK1Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sp+vaZRzn9s=:ODlKsZL59q3QKT6K6NAesI
 Sircrf6lv89kTV+TdUrN0uVtcmQK2RPMY5hf6hIpNgZeYgrQlXsx4fvK1wr9P1FlhFpw2Z/0D
 xDzCAnI4fkBq7vmw8Q4vxthLZK66ZFgZJyZmWZqGmJ1JZAULu+dIhdhG5XJ5aZZqe4cGszekS
 ELRf2Li7Q5KROnOUV0zdsCQ311k1Izb8+1dpXWKjO4HjkR/LNak0BXCAlSQj49HO71bcVt9br
 037EcsI7KnrqAOhMCejrJ45bJO4Xxc39ldpdj3dm+vc6c7QrYYb/ke8KtiGVhFsGKk0Wfg3Bx
 ViWqG01y0/mBnfHiPOnURnrDpn3ioO9ZqFcJojPgBQjeAngMDG0lw0Xkxl/A3jSUWYEzFpxty
 sO/Vpu7a6XejuxoJnam4ZQ3y3gwvhfA4I/OMaFH78gVFrZwqijn0CjR4pAuAP0IqzXaW0pZgF
 AtA1kRy9Qv3O64PZK+RJInG0ndfMqe3S7DxFYhgpp22vdLkznFq8TVJD+2JBVHhdCamSk41Uh
 3bIqenXzdO7veDuppLg6t+NhBwswSswFAg7pq4V1cjCrxsK4yNpdKjEvnhKG7ZjIU6z6DbYMS
 jcNQpk3IzSd6z/jnusDp3klLDBqozMatwJtiDJJ3I129yvZV0qQAsGa5n2Glw9EvC5+ECW5aq
 B/wlbQweOqXZIjVYJByT7q4J2PbGorS+ibsL1wd07MUCfTwLBMOiHtoNcSATAB0VrfRviu3/i
 +vZhU5DQWxv73fnn+cSItuGCJCw8I6oDYO6+lMBs3NS+TitWstM+mSmKCYY7AGihqxfNTjPHI
 1r5bjkp2SYERldUcaEJlgO+hwWO4RMdsEIh4JTOzf6NGo4F43+iW4UxTwZGQE8fX7YHxh0ASN
 Bw6jEsMt1/XgCxtSGOzqZsodAL7E1JrIcTfNnxzDm1XBAaSTol+Xq6sCOPZVSB3bRtqv1G588
 EUsbAp1VjhtVPX1oohn2VxyiiMWiNJ11o4j3seSXt0oHXgAuK9txMrUWk8tbimXvbkxD+hQWQ
 HtmVHgxvyxlRajV3ZndVX8AzfA7z3/BMknqf816PcctWAHzfO7EF71cqpbGc6RFFaqpTe/8oW
 uoV4FPFYBCIfhGMhYerEr8GtIfBWh948Tt85TpWy17MqEucyK/F95NhZcAMiQSIh6p3sKg/O1
 ozhmq3lggIgn5f+sFu63xeBxRfuV+X0KQ+iGcZZEd1pHsnXGd1z9BqymmsRnP3En5wMbfIRfj
 TfumKsgCmdb/Kgu9b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
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
Cc: Daniel Cho <danielcho@qnap.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Mar 2020 07:44:11 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Daniel Cho <danielcho@qnap.com>
> > Sent: Monday, February 24, 2020 3:15 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>; Zhanghailiang
> > <zhang.zhanghailiang@huawei.com>; qemu-devel@nongnu.org; Jason
> > Wang <jasowang@redhat.com>
> > Subject: Re: The issues about architecture of the COLO checkpoint
> >
> > Hi Zhang,
> >
> > Thanks for your help.
> > However, did you occur the error which the function qemu_hexdump in
> > colo-compare.c will crash the qemu process while doing operation with
> > network?
> >
>
> No, qemu_hexdump looks no relationship with network...
> Do you means it will crashed in qemu_hexdump sometimes?

Jeah, I hit that bug too, but it was fixed with
1e907a32b77e5d418538453df5945242e43224fa "COLO-compare: Fix incorrect `if`=
 logic"
in qemu 4.2.

Regards,
Lukas Straub

> > We are working on VM fault tolerance study and COLO function evalutati=
on
> > first. Currently we did not have a confirmed plan on it.
>
> OK, keep connection.
>
> Thanks
> Zhang Chen

