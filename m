Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86146C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A252166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIAIYF93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A252166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MgM-0006nz-Bz
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i3Mcz-00059L-4g
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i3Mcx-0004g1-Cr
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:46:24 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35526)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i3Mcv-0004bq-CN
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:46:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id g7so3969456wrx.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zTZpPNmP01jQ0kyjRltNFR9GN2wpMkhzJ3u17/tJprs=;
 b=xIAIYF930vVT9dm7lOAD2M22lIfw/kjX8Sx8k+u/NiU0PBAjJ0NCFaeFqr76txtjx1
 o2iHJhYun4vjJkJGTtpEdns8XpjzIjV1toTM6k7lfFQZgGTsGEs/54cX/bCVOkAMf6F+
 j60R9Y3jkCZm6foL7HWU0YdKbT7ohzcWWcG2yCjfcT+UvwXkodwuPXfc8cfgEPa4SFhw
 mAT7V2NOj8TJdvVs1nYOedKPd31LB4lL6PMPo3tt65Bt/015sVY8muOPazB2proucWfe
 WB5yCTc1+XCqCuh1ib+XcRB6XNMYdY5+tN2RmLRhJyv5Augy7MJ4TpuFRagTRvTzdx3K
 aCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zTZpPNmP01jQ0kyjRltNFR9GN2wpMkhzJ3u17/tJprs=;
 b=rnGqq7Q7R57kie6lK0gh+V68dxcQEss6ZDohluNCUGKtdgalasSikDeaySGlG4P9gw
 jSa1OKOTSIlplmmKcHEfJgDn6timPDRYC6z/RZVTjA50J/4Siftwxqn/v8379yeVJXma
 7qDxx3hoHHiv+Qivaa2Xu9mtY0qIhzZd6TC9g8S9405Y1C74dpkktXZ8tcj9+DS6lKzj
 jGV46Z+Y1hFTHTtubeD5FED0cr6qpiwsHfzfWEIB/0Qgeph+I2nijvv//U2mPipVQk05
 R5A7wcQDMyJsLQv2qKhzgTtPJZ/Tu3ZjJ/L8sLQhGRqgXWjumuJmKWudc8zkpbxTEVbo
 ykDg==
X-Gm-Message-State: APjAAAWPY2W9mdHvc/nsM71IzQjI9sPCxhhMrZWVmjnOiZqH1Qd0BRcp
 9QoT4I6H104DYB1Q8GTljnxUIQ==
X-Google-Smtp-Source: APXvYqxaET+sk+od0yAkL+rZjF15RZKTX4Vk4cTpMBenTZltAW+SOVRBqDFHOBjGaNvXfJpj4ebADw==
X-Received: by 2002:a5d:670d:: with SMTP id o13mr11869234wru.289.1567093578587; 
 Thu, 29 Aug 2019 08:46:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x6sm5946057wmf.6.2019.08.29.08.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 08:46:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 425A51FF87;
 Thu, 29 Aug 2019 16:46:17 +0100 (BST)
References: <20190829144120.12701-1-alex.bennee@linaro.org>
 <9e98702a-6582-3d38-c9a4-93f0279033bf@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <9e98702a-6582-3d38-c9a4-93f0279033bf@redhat.com>
Date: Thu, 29 Aug 2019 16:46:17 +0100
Message-ID: <871rx4560m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] tests/docker: upgrade docker.py to python3
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
Cc: Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 8/29/19 4:41 PM, Alex Benn=C3=A9e wrote:
>> The recent podman changes (9459f754134bb) imported enum which is part
>> of the python3 standard library but only available as an external
>> library for python2. This causes problems on the fairly restricted
>> environment such as shippable. Lets bite the bullet and make the
>> script a fully python3 one. To that end:
>>
>>   - drop the from __future__ import (we are there now ;-)
>>   - avoid the StringIO import hack
>>   - be consistent with the mode we read/write dockerfiles
>>   - s/iteritems/items/
>>   - ensure check_output returns strings for processing
>
> Many boring changes at once...
>
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/docker/docker.py | 27 ++++++++++++++-------------
>>  1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>> index ac5baab4cad..4bba29e104e 100755
>> --- a/tests/docker/docker.py
>> +++ b/tests/docker/docker.py
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/env python2
>> +#!/usr/bin/env python3
>>  #
>>  # Docker controlling module
>>  #
>> @@ -11,7 +11,6 @@
>>  # or (at your option) any later version. See the COPYING file in
>>  # the top-level directory.
>>
>> -from __future__ import print_function
>>  import os
>>  import sys
>>  import subprocess
>> @@ -25,10 +24,7 @@ import tempfile
>>  import re
>>  import signal
>>  from tarfile import TarFile, TarInfo
>> -try:
>> -    from StringIO import StringIO
>> -except ImportError:
>> -    from io import StringIO
>> +from io import StringIO
>>  from shutil import copy, rmtree
>>  from pwd import getpwuid
>>  from datetime import datetime, timedelta
>> @@ -62,11 +58,13 @@ USE_ENGINE =3D EngineEnum.AUTO
>>
>>  def _text_checksum(text):
>>      """Calculate a digest string unique to the text content"""
>> -    return hashlib.sha1(text).hexdigest()
>> +    return hashlib.sha1(text.encode('utf-8')).hexdigest()
>>
>> +def _read_dockerfile(path):
>> +    return open(path, 'rt', encoding=3D'utf-8').read()
>
> TIL it's cleaner to explicit the 't' mode.

Yeah it is the default but I favoured being explicit and bringing it all
together in one place...

>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks

>
>>  def _file_checksum(filename):
>> -    return _text_checksum(open(filename, 'rb').read())
>> +    return _text_checksum(_read_dockerfile(filename))
>>
>>
>>  def _guess_engine_command():
>> @@ -192,7 +190,7 @@ def _read_qemu_dockerfile(img_name):
>>
>>      df =3D os.path.join(os.path.dirname(__file__), "dockerfiles",
>>                        img_name + ".docker")
>> -    return open(df, "r").read()
>> +    return _read_dockerfile(df)
>>
>>
>>  def _dockerfile_preprocess(df):
>> @@ -262,6 +260,7 @@ class Docker(object):
>>      def _output(self, cmd, **kwargs):
>>          return subprocess.check_output(self._command + cmd,
>>                                         stderr=3Dsubprocess.STDOUT,
>> +                                       encoding=3D'utf-8',
>>                                         **kwargs)
>>
>>      def inspect_tag(self, tag):
>> @@ -283,7 +282,9 @@ class Docker(object):
>>          if argv is None:
>>              argv =3D []
>>
>> -        tmp_df =3D tempfile.NamedTemporaryFile(dir=3Ddocker_dir, suffix=
=3D".docker")
>> +        tmp_df =3D tempfile.NamedTemporaryFile(mode=3D"w+t",
>> +                                             encoding=3D'utf-8',
>> +                                             dir=3Ddocker_dir, suffix=
=3D".docker")
>>          tmp_df.write(dockerfile)
>>
>>          if user:
>> @@ -396,7 +397,7 @@ class BuildCommand(SubCommand):
>>                              help=3D"Dockerfile name")
>>
>>      def run(self, args, argv):
>> -        dockerfile =3D open(args.dockerfile, "rb").read()
>> +        dockerfile =3D _read_dockerfile(args.dockerfile)
>>          tag =3D args.tag
>>
>>          dkr =3D Docker()
>> @@ -442,7 +443,7 @@ class BuildCommand(SubCommand):
>>                  cksum +=3D [(filename, _file_checksum(filename))]
>>
>>              argv +=3D ["--build-arg=3D" + k.lower() + "=3D" + v
>> -                     for k, v in os.environ.iteritems()
>> +                     for k, v in os.environ.items()
>>                       if k.lower() in FILTERED_ENV_NAMES]
>>              dkr.build_image(tag, docker_dir, dockerfile,
>>                              quiet=3Dargs.quiet, user=3Dargs.user, argv=
=3Dargv,
>> @@ -611,7 +612,7 @@ class CheckCommand(SubCommand):
>>                  print("Need a dockerfile for tag:%s" % (tag))
>>                  return 1
>>
>> -            dockerfile =3D open(args.dockerfile, "rb").read()
>> +            dockerfile =3D _read_dockerfile(args.dockerfile)
>>
>>              if dkr.image_matches_dockerfile(tag, dockerfile):
>>                  if not args.quiet:
>>


--
Alex Benn=C3=A9e

