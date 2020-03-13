Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247D1C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85A92072C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yblzl/fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85A92072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCkz9-0007f6-3F
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jCkxl-00061U-IB
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jCkxk-0004Tl-G4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:06:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jCkxk-0004LD-83
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:06:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id r15so12266428wrx.6
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 07:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Hd8dq4YRRXXBUTBa41qw1iCjSDdmQfJL9aQ4cSEPc2w=;
 b=yblzl/fY9Wihr5cvNC4d1Xq9/cpj/QYocqeXSlZWzl0YYKL/qsV4KHx2Lqe2iCJMav
 L7NV/9yLsoOL23/QP3yrmnsTFJLXbkxnSYD2jxPON8MX2o0THHlkWK4QC5uLUBQW8Lg+
 +7NWKwp++eBXlQf7m1oukbc4/giiSAq76Lxl1hhuFgnUM0FdChPvnubsqXzj5RZ6ck24
 avwbL3egvB3ZRtYxTRRtkK218nJjNmkYVGBdHnLI4sd6BwszTZLZn8yCtXb5vltRBzhY
 08FOGX1vmkKjwB0FA+byrMxVFUBmYd2Dy1lL+Oi3yObLzkwp5ikqOLf63TABR0YBYIOv
 uqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Hd8dq4YRRXXBUTBa41qw1iCjSDdmQfJL9aQ4cSEPc2w=;
 b=cnbdJqLEXw0PlK/G1bH3GnmfAzqU+oCfAGCK/ttqh1RGZlYltOFaoLSzMRBpPq3W9c
 77Uql/NskOD8z42xvXXIMQ/ni+tXAANEcA0r0u57VdOMJrHxVUan1lcYuyzLhKC4epc/
 eBV0PDCzcWt+IIk1cuzF2TF10cfFaWxfyEQTnZV6plw6FmdtNg6rS3hQ2horxZPiX3+O
 6Xfqelc+EtikEgphRITDxe9rNz/TXb+77KfIV6akqqUWzwCGnsFRFK3xGcTVjSIspkuK
 MEyfhDHFrgU9237cvPO8E7LH2qfuBwVDzUm1VXuLEZkg29qmNZQDJxMH6PAp8SDlR+M3
 IsfQ==
X-Gm-Message-State: ANhLgQ2bC391JdCykpa6FEyw+jqLqltpLHPVVH8ZyDIAOAmcG5fSglzd
 aZihnfbITyYDAi1cONse/nsPKHM9PpI=
X-Google-Smtp-Source: ADFU+vst+qbySmqVWrmvTQyeoclOpoRlSlFwC/C6yB+zd1p7UyvZEujtYuTyuKRufY7nzCfCeHQUQQ==
X-Received: by 2002:adf:afcb:: with SMTP id y11mr17105234wrd.141.1584108414099; 
 Fri, 13 Mar 2020 07:06:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x5sm18316100wrv.67.2020.03.13.07.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 07:06:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BA021FF7E;
 Fri, 13 Mar 2020 14:06:52 +0000 (GMT)
References: <20200312193616.438922-1-crosa@redhat.com>
 <20200312193616.438922-2-crosa@redhat.com>
 <20200313084655.GC293912@beluga.usersys.redhat.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Erik Skultety <eskultet@redhat.com>
Subject: Re: [PATCH 1/5] tests/docker: add CentOS 8 Dockerfile
In-reply-to: <20200313084655.GC293912@beluga.usersys.redhat.com>
Date: Fri, 13 Mar 2020 14:06:52 +0000
Message-ID: <87imj8cps3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Erik Skultety <eskultet@redhat.com> writes:

> On Thu, Mar 12, 2020 at 03:36:12PM -0400, Cleber Rosa wrote:
>> Which is currenly missing, and will be referenced later in the
>> contributed CI playbooks.
>>=20
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>  tests/docker/dockerfiles/centos8.docker | 32 +++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>  create mode 100644 tests/docker/dockerfiles/centos8.docker
>>=20
>> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dock=
erfiles/centos8.docker
>> new file mode 100644
>> index 0000000000..bfa0d33c9c
>> --- /dev/null
>> +++ b/tests/docker/dockerfiles/centos8.docker
>> @@ -0,0 +1,32 @@
>> +FROM centos:8.1.1911
>> +
>> +RUN dnf -y update
>> +ENV PACKAGES \
>> +    SDL-devel \
>> +    bison \
>> +    bzip2 \
>> +    bzip2-devel \
>> +    dbus-daemon \
>> +    flex \
>> +    gcc \
>> +    gcc-c++ \
>> +    gettext \
>> +    git \
>> +    glib2-devel \
>> +    libaio-devel \
>> +    libepoxy-devel \
>> +    lzo-devel \
>> +    make \
>> +    mesa-libEGL-devel \
>> +    nettle-devel \
>> +    perl-Test-Harness \
>> +    pixman-devel \
>> +    python36 \
>> +    rdma-core-devel \
>> +    spice-glib-devel \
>> +    spice-server \
>> +    tar \
>> +    zlib-devel
>> +
>> +RUN dnf install -y $PACKAGES
>> +RUN rpm -q $PACKAGES | sort > /packages.txt
>
> How is the packages.txt consumed later?

I think it's just following the pattern of a number of the containers by du=
mping the
package list for later reference by the run support scripts (tests/docker/r=
un):

  if test -n "$SHOW_ENV"; then
      if test -f /packages.txt; then
          echo "Packages installed:"
          cat /packages.txt
          echo
      fi
      echo "Environment variables:"
      env
      echo
  fi

>
> Erik


--=20
Alex Benn=C3=A9e

