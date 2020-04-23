Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD88C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C3C2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IrZKYDvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C3C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZSz-0005FY-P5
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 06:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jRZSD-0004qE-A6
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1jRZSC-0007Ry-7J
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:51:37 -0400
Received: from m12-13.163.com ([220.181.12.13]:47834)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zxq_yx_007@163.com>)
 id 1jRZSA-0007Mk-On
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=avrKX
 lh7r9JE42tY0xBIT4esbkUqdSAcyVXyUCssfv4=; b=IrZKYDvWXl8CyxPXKyylA
 tXRtnbcWZg6hojgzGs98nA88p8bzGekHsBWV8F+52AUre/YXOpAXHn/Ue2CHGZfS
 RZUm+WtpLXwsnU850a8/d+2Y5ullY8R4PoLKrfsK1LVeQHOr9CB/oMARCxjBFYK6
 U4HorXZsMujhiRtWn8ckK4=
Received: from [10.11.32.45] (unknown [39.155.168.46])
 by smtp9 (Coremail) with SMTP id DcCowADn7KQvc6FepKZtBA--.6439S2;
 Thu, 23 Apr 2020 18:51:27 +0800 (CST)
Subject: Re: [PATCH v2] qemu-sockets: add abstract UNIX domain socket support
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200423035640.29202-1-zxq_yx_007@163.com>
 <20200423090006.GA1077680@redhat.com>
From: "xiaoqiang.zhao" <zxq_yx_007@163.com>
Message-ID: <b3f0ebc4-08f5-22e2-ead8-e8651d4b5798@163.com>
Date: Thu, 23 Apr 2020 18:51:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423090006.GA1077680@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: DcCowADn7KQvc6FepKZtBA--.6439S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyUKrWkuryrKr45XF1rXrb_yoWrWryfpa
 y5Ka1Dt393JF409rs5uw45GrWSya1rA3yUKwn5J3sYkws0gF1I9F1Iq3WYv347J398K3y7
 t3yYkry7Z3Z8AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jGMKZUUUUU=
X-Originating-IP: [39.155.168.46]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEAwPxlUMQlUmUgAAsv
Received-SPF: pass client-ip=220.181.12.13; envelope-from=zxq_yx_007@163.com;
 helo=m12-13.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:51:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Received-From: 220.181.12.13
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
Cc: armbru@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

在 2020/4/23 下午5:00, Daniel P. Berrangé 写道:
> Adding Eric & Markus for QAPI modelling questions
>
> On Thu, Apr 23, 2020 at 11:56:40AM +0800, xiaoqiang zhao wrote:
>> unix_connect_saddr now support abstract address type
>>
>> By default qemu does not support abstract UNIX domain
>> socket address. Add this ability to make qemu handy
>> when abstract address is needed.
> Was that a specific app you're using with QEMU that needs this ?

Thanks for your reply !

I once use qemu to connect a unix domain socket server (with abstract 
type address written by android java code)

>> Abstract address is marked by prefixing the address name with a '@'.
> For full support of the abstract namespace we would ned to allow
> the "sun_path" to contain an arbitrary mix of NULs and non-NULs
> characters, and allow connect() @addrlen to be an arbitrary size.
>
> This patch only allows a single initial NUL, and reqiures @addrlen
> to be the full size of sun_path, padding with trailing NULs. This
> limitation is impossible to lift with QEMU's current approach to
> UNIX sockets, as it relies on passing around a NULL terminated
> string, so there's no way to have embedded NULs. Since there's
> no explicit length, we have to chooose between forcing the full
> sun_path size as @addrlen, or forcing the string length as the
> @addrlen value.
>
> IIUC, socat makes the latter decision by default, but has a
> flag to switch to the former.
>
>    [man socat]
>    unix-tightsocklen=[0|1]
>    On  socket  operations,  pass  a  socket  address  length that does not
>    include the whole struct sockaddr_un record but (besides  other  compo‐
>    nents)  only  the  relevant  part  of  the filename or abstract string.
>    Default is 1.
>    [/man]
>
> This actually is supported for both abstract and non-abstract
> sockets, though IIUC this doesn't make a semantic difference
> for non-abstract sockets.
>
> The point is we have four possible combinations
>
>   NON-ABSTRACT + FULL SIZE
>   NON-ABSTRACT + MINIMAL SIZE  (default)
>   ABSTRACT + FULL SIZE
>   ABSTRACT + MINIMAL SIZE  (default)
>
> With your patch doing the latter, it means QEMU supports
> only two combinations
>
>    NON+ABSTRACT + FULL SIZE
>    ABSTRACT + MINIMAL SIZE
>
> and also can't use "@somerealpath" for a non-abstract
> socket, though admittedly this is unlikely.
>
> Socat uses a special option to request use of abstract
> sockets. eg ABSTRACT:somepath, and automatically adds
> the leading NUL, so there's no need for a special "@"
> character. This means that UNIX:@somepath still resolves
> to a filesystem path and not a abstract socket path.
>
> Finally, the patch as only added support for connect()
> not listen(). I think if QEMU wants to support abstract
> sockets we must do both, and also have unit tests added
> to tests/test-util-sockets.c
Yes , I missed these parts.
>
>
> The question is whether we're ok with this simple
> approach in QEMU, or should do a full approach with
> more explicit modelling.
Agree,  more comments is welcome.
>
> ie should we change QAPI thus:
>
> { 'struct': 'UnixSocketAddress',
>    'data': {
>      'path': 'str',
>      'tight': 'bool',
>      'abstract': 'bool' } }
>
> where 'tight' is a flag indicating whether to set @addrlen
> to the minimal string length, or the maximum sun_path length.
> And 'abstract' indicates that we automagically add a leading
> NUL.
>
> This would *not* allow for NULs in the middle of path,
> but I'm not so bothered about that, since I can't see that
> being widely used. If we really did need that it could be
> added via a 'base64': 'bool' flag, to indicate that @path
> is base64 encoded and thus may contain NULs
>
>  From a CLI POV, this could be mapped to QAPI thus
>
>   *  -chardev unix:somepath
>
>        @path==somepath
>        @tight==false
>        @abstract==false
>
>   *  -chardev unix:somepath,tight
>
>        @path==somepath
>        @tight==true
>        @abstract==false
>
>   *  -chardev unix-abstract:somepath
>
>        @path==somepath
>        @tight==false
>        @abstract==true
>
>   *  -chardev unix-abstract:somepath,tight
>
>        @path==somepath
>        @tight==true
>        @abstract==true
>
>
>
> Regards,
> Daniel


