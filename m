Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C08C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:30:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F16520757
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 19:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCtwY5sB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F16520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMct7-0006qd-3w
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 15:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jMcs7-0006BL-H2
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jMcs5-0007Zd-Td
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:29:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jMcs5-0007Z8-N9
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 15:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586460592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFvnZJIthz0YFlYhGubIN3/hkY5KMR3utfmD3RBJ5so=;
 b=UCtwY5sBZSlxGe8J1tJyHQDxNyROg1mnOo0y3/UwqPL9hmjRoLVBfQr2vXqgOp+sa5SIVS
 ahHisOuWj/lw25k3h3R+cZG4fQ9+FgNzc3+54jGEt1CUeU2/NxErBIUMlfxfIvKlCK8fVj
 ZuWF9LySwsIdE+IUYtjlZGW5/X9SyP4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-D_3BGHJ0OiaD9nNkKM9RDw-1; Thu, 09 Apr 2020 15:29:50 -0400
X-MC-Unique: D_3BGHJ0OiaD9nNkKM9RDw-1
Received: by mail-ed1-f72.google.com with SMTP id d1so13438edq.11
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 12:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ADaL5qke6Nom6WR7uhGTYHQaFqo0A1CNIf5rgwRf+6g=;
 b=gVs+OebJospIPmm2lX1Jh9hVp3aHxmpK7929xWJsF0embaVKHIC5OD2sjiL+8jIeDF
 WYZZvDHWgnC6r3ziNZLPJdLAoUL5SrMHO7bQvjM4tfSNxv/HDnJj5P2OemsKBIT/8arx
 VrUXDh/STuNUQKWkrU70jDm3R43XJWtbMIoKCz5GHG4KesV7XCprcsjTyfdt7UKBpH3I
 T3Qkj6hF/jEBDZAKhqOZyvj5VBczReVC1dC8yHuywS0ZF3IRbGjt+q2zxq+E2F8TWBQL
 2yj2lJWBpk17Bsejzp8+wWsd0RZfRKIZJ9C3PE5pCypT8iisqB/QSPfLSoYagHlVsx7O
 CLiQ==
X-Gm-Message-State: AGi0Pub3aAW9nZTkumM3im6FVRGbJ9oSpDLt6kPmZSnYaOFoK5sEGPb3
 emfyM28v769S6cXXmt8LC4R+b3n9MPRtER5ZZHKcYG8OXdmBJQsrH3Vu0DEtCWB2v9IbgeN389A
 h0e7rnmoSx6BDc3U=
X-Received: by 2002:a17:906:8da:: with SMTP id
 o26mr612965eje.288.1586460589092; 
 Thu, 09 Apr 2020 12:29:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypK52HFF11eqWmnmLxcNbuiJSLMxohzMMpygZAve3z8PCL0DC+fg6PdG/R2m0hD+ftftpBsGrg==
X-Received: by 2002:a17:906:8da:: with SMTP id
 o26mr612945eje.288.1586460588855; 
 Thu, 09 Apr 2020 12:29:48 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id u2sm459edj.21.2020.04.09.12.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2020 12:29:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] gdbstub: i386: Fix gdb_get_reg16() parameter to
 unbreak gdb
To: Peter Xu <peterx@redhat.com>
References: <20200409164954.36902-1-peterx@redhat.com>
 <20200409164954.36902-3-peterx@redhat.com>
 <b559bedc-c6d7-922b-35fd-96ac4f068d9b@redhat.com>
 <20200409180130.GA10061@xz-x1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6cd605a3-1369-9714-321e-5d1c6fcbfc39@redhat.com>
Date: Thu, 9 Apr 2020 21:29:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409180130.GA10061@xz-x1>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/9/20 8:01 PM, Peter Xu wrote:
> Hi, Phil,
>=20
> On Thu, Apr 09, 2020 at 07:21:04PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 4/9/20 6:49 PM, Peter Xu wrote:
>>> We should only pass in gdb_get_reg16() with the GByteArray* object
>>> itself, no need to shift.  Without this patch, gdb remote attach will
>>> crash QEMU.
>>
>> You are correct.
>>
>> Fixes: a010bdbe719 ("extend GByteArray to read register helpers")
>=20
> Oh I forgot to paste the fix line.  However, is it b7b8756a9c
> ("target/i386: use gdb_get_reg helpers", 2020-03-17) instead?

b7b8756a9c is correct, at that time the codebase was using the correct=20
API. the next commit updated the API but missed to update the lines you=20
are fixed. So I think "fixes a010bdbe719" is correct.

>=20
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Thanks!
>=20
>>
>> Same problem in m68k_fpu_gdb_get_reg().
>>
>> TODO for 5.1, rename mem_buf -> array.
>=20


