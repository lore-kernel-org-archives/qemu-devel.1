Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974DC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:28:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53ED620684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 08:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtnZ+kmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53ED620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itSQ2-0001tZ-CK
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 03:28:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itSPG-0001SL-RJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itSPD-0006XT-Av
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:27:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itSPD-0006Wx-7n
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 03:27:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579508849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQAvoSIP8EVYyXOl9RgB2qnpprOizhly1mFBuc1c04Y=;
 b=GtnZ+kmkLyPTrCbwyTZKHure5hQFZNUE8loNqN/NfjvK2iVNM6fBi7qJt7v8Nngcx624wv
 I/IMEkyAKNjWJmxDtqqf051XV8a++XaYuB8gf521BwhkyHTycM4thSVz3PJltyTXcsh20F
 XQGAK95y9hkT3fe8xeUMX6fbTENwSt8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-C7QumgGHMOqoS33k_VGUGw-1; Mon, 20 Jan 2020 03:27:25 -0500
Received: by mail-wm1-f70.google.com with SMTP id 18so3446868wmp.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 00:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0NkXP26a348TM5/SeVnXPolPxmaE/YYpylQAsqwued4=;
 b=l196OqhwOj7Ks9qcJgx8kCtQOY1Xa2s+9yHLaKpvykpWstbfQ/ivZ/RAgykTjdFj80
 RkJRlGn2Ptnx+8n96x/MPsloIVueQ5beVESKa3nz6gkWJbZ7q7HnHyPkaw5tDvHYiyH4
 1yVauKnOBb77Y+lDzY/W/hemH+m3XIDSReH49Dj5r5KAvePMK75u87GhJuA7a24I6djc
 1Relw64GzNhvi5EJwpGjpEs3gQA8EDKaz3kCIyzptifkdnyfGKaNxKC+3AltZ5I2QzKu
 fZQxGOrJCDy9TBhYbVrKCVRFHq6cbLNh7c+rhx+kNKh5wb+hGnefhyPtdp6NqjOaC+EK
 nueQ==
X-Gm-Message-State: APjAAAUOpiYtrS1XF9/2roNgRv4EQmUUxWggicsNco+Telw5LLqU5Qpg
 lgZRaJ8189RQyqVj8fluKbdbq8bkXOoD4BJ4Qm2TNYTQzRUIFZ8LRzb9UKp0e9qIHnnKMzCG4vQ
 /+6/WnqyYnTALY5M=
X-Received: by 2002:a7b:c847:: with SMTP id c7mr16956620wml.3.1579508844676;
 Mon, 20 Jan 2020 00:27:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqxIExzX492EmspkkiMnkMGP7V6nBuu4PNpR0AyQuWwqpdGE2C2CNS26lX2tLAjF/1ThW1PBwQ==
X-Received: by 2002:a7b:c847:: with SMTP id c7mr16956606wml.3.1579508844359;
 Mon, 20 Jan 2020 00:27:24 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id p17sm1802208wmk.30.2020.01.20.00.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 00:27:23 -0800 (PST)
Subject: Re: [PATCH 105/104] virtiofsd: Unref old/new inodes with the same
 mutex lock in lo_rename()
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20200117133257.16906-1-philmd@redhat.com> <5E2414D8.8080601@cn.fujitsu.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39015ba1-4ff9-13ee-47c6-c6889613602e@redhat.com>
Date: Mon, 20 Jan 2020 09:27:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5E2414D8.8080601@cn.fujitsu.com>
Content-Language: en-US
X-MC-Unique: C7QumgGHMOqoS33k_VGUGw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Vivek Goyal <vgoyal@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/19/20 9:35 AM, Xiao Yang wrote:
> On 2020/1/17 21:32, Philippe Mathieu-Daud=C3=A9 wrote:
>> We can unref both old/new inodes with the same mutex lock.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9<philmd@redhat.com>
>> ---
>> Based-on:<20191212163904.159893-1-dgilbert@redhat.com>
>> "virtiofs daemon"
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg664652.html
>>
>> =C2=A0 tools/virtiofsd/passthrough_ll.c | 6 ++++--
>> =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/virtiofsd/passthrough_ll.c=20
>> b/tools/virtiofsd/passthrough_ll.c
>> index 57f58aef26..5c717cb5a1 100644
>> --- a/tools/virtiofsd/passthrough_ll.c
>> +++ b/tools/virtiofsd/passthrough_ll.c
>> @@ -1461,8 +1461,10 @@ static void lo_rename(fuse_req_t req,=20
>> fuse_ino_t parent, const char *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0 out:
>> -=C2=A0=C2=A0=C2=A0 unref_inode_lolocked(lo, oldinode, 1);
>> -=C2=A0=C2=A0=C2=A0 unref_inode_lolocked(lo, newinode, 1);
>> +=C2=A0=C2=A0=C2=A0 pthread_mutex_lock(&lo->mutex);
>> +=C2=A0=C2=A0=C2=A0 unref_inode(lo, oldinode, 1);
>> +=C2=A0=C2=A0=C2=A0 unref_inode(lo, newinode, 1);
>> +=C2=A0=C2=A0=C2=A0 pthread_mutex_unlock(&lo->mutex);
> Hi,
>=20
> It seems to avoid calling pthread_mutex_lock and pthread_mutex_unlock=20
> twice.
> Does the change fix some issues or improve the performance?

No issue, simply intend to improve the performance.

> Best Regards,
> Xiao Yang
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo_inode_put(lo,&oldinode);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo_inode_put(lo,&newinode);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lo_inode_put(lo,&parent_inode);
>=20
>=20
>=20


