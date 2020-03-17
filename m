Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D4C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B62320663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SXd3F183"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B62320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9f1-0004lA-4o
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9as-0006sj-3B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:37:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9al-0006Me-J5
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:37:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39827)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9al-0006LX-1n
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFMUEOScdpBuf/Mx70J4VPVYWYWsxoqazOHuTFGRmQE=;
 b=SXd3F183bzLTwAv0/9m3pVEv06R3vZW+i+aqfVzdoYYrWHRo5pSEDj8op0pKFy+k+eu6om
 R5tdZHZSVe2ps1h3Eg4tD7wUjzqjkL4+90KEh8/HL7YliU2UrgaMkKaTt956tHTHlgCVz0
 yQRloF9OKoQKmBMShpWtEqN/dLQrxOk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-voAndo5vNTmik6zpbW81AQ-1; Tue, 17 Mar 2020 06:36:52 -0400
X-MC-Unique: voAndo5vNTmik6zpbW81AQ-1
Received: by mail-wr1-f71.google.com with SMTP id l16so9761414wrr.6
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SeaMdi8Q37M4RnEotaj6D84jED/dfBHFE+b/oq5C5U0=;
 b=Kd+erIYdUnFd92fzBzhLhHWEuzB7Y+lvm3qpzh/xy8ubxLuXHu2/PmV8cm4vkcDX7m
 Ar614r4l9xvcIQ9+KdI94g4kIRXH4yyUeR+2Ddx3qWj88zG/R8gp9KzEfE7n+IX4VpcO
 +OPnMAOZtCfTKPM4vXueTf73PxOxYcySlPEBH8wj8co5pqYnPZbvl9wcwhLTHliIJR8M
 WQNLR1SGccqhEt4A4cbc3yGcL4iBK5pg8asiS77kSUr+byUKNyMCKk1/hJEFBogpRFaH
 PGey6tVD2al5Iw9woFtnhNy3z45art+ZsXrcfR8inrnhZMKlZnX6IOYTw4aaBYuR344p
 H3pg==
X-Gm-Message-State: ANhLgQ13PA8+YNNTOKrY+rr0/ta/jKlUsVf6qPWrgxZb3rSL1KZupQRX
 a5Tc9FGzY7+Z6cZa0odvX5cwAz0LDZ+9yAJ8dpvkkKgTEZK7yYgZ7PFS80qgK5dfTV6PssVvqAu
 tW35b+Cl7tynafg8=
X-Received: by 2002:adf:fc82:: with SMTP id g2mr5609434wrr.117.1584441411442; 
 Tue, 17 Mar 2020 03:36:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu5fiD/ITrklkrcn0fDyYmUtctdIuU7P6QJ330qd/fGxZugIDemcBwARTmmYOijYIm+Bt/SrQ==
X-Received: by 2002:adf:fc82:: with SMTP id g2mr5609411wrr.117.1584441411197; 
 Tue, 17 Mar 2020 03:36:51 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b5sm3880839wrj.1.2020.03.17.03.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:36:50 -0700 (PDT)
Subject: Re: [PATCH v8 07/11] iotests: limit line length to 79 chars
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200317004105.27059-1-jsnow@redhat.com>
 <20200317004105.27059-8-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b4046db-99c6-a431-02fc-4f0c4882df76@redhat.com>
Date: Tue, 17 Mar 2020 11:36:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317004105.27059-8-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 1:41 AM, John Snow wrote:
> 79 is the PEP8 recommendation. This recommendation works well for
> reading patch diffs in TUI email clients.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 64 +++++++++++++++++++++++------------
>   tests/qemu-iotests/pylintrc   |  6 +++-
>   2 files changed, 47 insertions(+), 23 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 3d90fb157d..75fd697d77 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -77,9 +77,11 @@
>   def qemu_img(*args):
>       '''Run qemu-img and return the exit code'''
>       devnull =3D open('/dev/null', 'r+')
> -    exitcode =3D subprocess.call(qemu_img_args + list(args), stdin=3Ddev=
null, stdout=3Ddevnull)
> +    exitcode =3D subprocess.call(qemu_img_args + list(args),
> +                               stdin=3Ddevnull, stdout=3Ddevnull)
>       if exitcode < 0:
> -        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
> +        sys.stderr.write('qemu-img received signal %i: %s\n'
> +                         % (-exitcode, ' '.join(qemu_img_args + list(arg=
s))))
>       return exitcode
>  =20
>   def ordered_qmp(qmsg, conv_keys=3DTrue):
> @@ -118,7 +120,8 @@ def qemu_img_verbose(*args):
>       '''Run qemu-img without suppressing its output and return the exit =
code'''
>       exitcode =3D subprocess.call(qemu_img_args + list(args))
>       if exitcode < 0:
> -        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
> +        sys.stderr.write('qemu-img received signal %i: %s\n'
> +                         % (-exitcode, ' '.join(qemu_img_args + list(arg=
s))))
>       return exitcode
>  =20
>   def qemu_img_pipe(*args):
> @@ -129,7 +132,8 @@ def qemu_img_pipe(*args):
>                               universal_newlines=3DTrue)
>       exitcode =3D subp.wait()
>       if exitcode < 0:
> -        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
> +        sys.stderr.write('qemu-img received signal %i: %s\n'
> +                         % (-exitcode, ' '.join(qemu_img_args + list(arg=
s))))
>       return subp.communicate()[0]
>  =20
>   def qemu_img_log(*args):
> @@ -159,7 +163,8 @@ def qemu_io(*args):
>                               universal_newlines=3DTrue)
>       exitcode =3D subp.wait()
>       if exitcode < 0:
> -        sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode=
, ' '.join(args)))
> +        sys.stderr.write('qemu-io received signal %i: %s\n'
> +                         % (-exitcode, ' '.join(args)))
>       return subp.communicate()[0]
>  =20
>   def qemu_io_log(*args):
> @@ -281,10 +286,13 @@ def filter_test_dir(msg):
>   def filter_win32(msg):
>       return win32_re.sub("", msg)
>  =20
> -qemu_io_re =3D re.compile(r"[0-9]* ops; [0-9\/:. sec]* \([0-9\/.inf]* [E=
PTGMKiBbytes]*\/sec and [0-9\/.inf]* ops\/sec\)")
> +qemu_io_re =3D re.compile(r"[0-9]* ops; [0-9\/:. sec]* "
> +                        r"\([0-9\/.inf]* [EPTGMKiBbytes]*\/sec "
> +                        r"and [0-9\/.inf]* ops\/sec\)")
>   def filter_qemu_io(msg):
>       msg =3D filter_win32(msg)
> -    return qemu_io_re.sub("X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/se=
c)", msg)
> +    return qemu_io_re.sub("X ops; XX:XX:XX.X "
> +                          "(XXX YYY/sec and XXX ops/sec)", msg)
>  =20
>   chown_re =3D re.compile(r"chown [0-9]+:[0-9]+")
>   def filter_chown(msg):
> @@ -336,7 +344,9 @@ def filter_img_info(output, filename):
>           line =3D line.replace(filename, 'TEST_IMG') \
>                      .replace(imgfmt, 'IMGFMT')
>           line =3D re.sub('iters: [0-9]+', 'iters: XXX', line)
> -        line =3D re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-XX=
XX-XXXXXXXXXXXX', line)
> +        line =3D re.sub('uuid: [-a-f0-9]+',
> +                      'uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
> +                      line)
>           line =3D re.sub('cid: [0-9]+', 'cid: XXXXXXXXXX', line)
>           lines.append(line)
>       return '\n'.join(lines)
> @@ -529,11 +539,13 @@ def pause_drive(self, drive, event=3DNone):
>               self.pause_drive(drive, "write_aio")
>               return
>           self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, =
event, drive))
> +                 command_line=3D'qemu-io %s "break %s bp_%s"'
> +                 % (drive, event, drive))
>  =20
>       def resume_drive(self, drive):
>           self.qmp('human-monitor-command',
> -                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (dri=
ve, drive))
> +                 command_line=3D'qemu-io %s "remove_break bp_%s"'
> +                 % (drive, drive))
>  =20
>       def hmp_qemu_io(self, drive, cmd):
>           '''Write to a given drive using an HMP command'''
> @@ -793,16 +805,18 @@ def dictpath(self, d, path):
>                   idx =3D int(idx)
>  =20
>               if not isinstance(d, dict) or component not in d:
> -                self.fail('failed path traversal for "%s" in "%s"' % (pa=
th, str(d)))
> +                self.fail(f'failed path traversal for "{path}" in "{d}"'=
)
>               d =3D d[component]
>  =20
>               if m:
>                   if not isinstance(d, list):
> -                    self.fail('path component "%s" in "%s" is not a list=
 in "%s"' % (component, path, str(d)))
> +                    self.fail(f'path component "{component}" in "{path}"=
 '
> +                              f'is not a list in "{d}"')
>                   try:
>                       d =3D d[idx]
>                   except IndexError:
> -                    self.fail('invalid index "%s" in path "%s" in "%s"' =
% (idx, path, str(d)))
> +                    self.fail(f'invalid index "{idx}" in path "{path}" '
> +                              f'in "{d}"')
>           return d
>  =20
>       def assert_qmp_absent(self, d, path):
> @@ -853,10 +867,13 @@ def assert_json_filename_equal(self, json_filename,=
 reference):
>           '''Asserts that the given filename is a json: filename and that=
 its
>              content is equal to the given reference object'''
>           self.assertEqual(json_filename[:5], 'json:')
> -        self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_file=
name[5:])),
> -                         self.vm.flatten_qmp_object(reference))
> +        self.assertEqual(
> +            self.vm.flatten_qmp_object(json.loads(json_filename[5:])),
> +            self.vm.flatten_qmp_object(reference)
> +        )
>  =20
> -    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resume=3D=
False, wait=3D60.0):
> +    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse,
> +                        resume=3DFalse, wait=3D60.0):
>           '''Cancel a block job and wait for it to finish, returning the =
event'''
>           result =3D self.vm.qmp('block-job-cancel', device=3Ddrive, forc=
e=3Dforce)
>           self.assert_qmp(result, 'return', {})
> @@ -880,8 +897,8 @@ def cancel_and_wait(self, drive=3D'drive0', force=3DF=
alse, resume=3DFalse, wait=3D60.0):
>           self.assert_no_active_block_jobs()
>           return result
>  =20
> -    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
, wait=3D60.0,
> -                             error=3DNone):
> +    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue=
,
> +                             wait=3D60.0, error=3DNone):
>           '''Wait for a block job to finish, returning the event'''
>           while True:
>               for event in self.vm.get_qmp_events(wait=3Dwait):
> @@ -1020,8 +1037,11 @@ def verify_quorum():
>           notrun('quorum support missing')
>  =20
>   def qemu_pipe(*args):
> -    '''Run qemu with an option to print something and exit (e.g. a help =
option),
> -    and return its output'''
> +    """
> +    Run qemu with an option to print something and exit (e.g. a help opt=
ion).
> +
> +    :return: QEMU's stdout output.
> +    """
>       args =3D [qemu_prog] + qemu_opts + list(args)
>       subp =3D subprocess.Popen(args, stdout=3Dsubprocess.PIPE,
>                               stderr=3Dsubprocess.STDOUT,
> @@ -1059,8 +1079,8 @@ def func_wrapper(test_case: QMPTestCase, *args, **k=
wargs):
>  =20
>               usf_list =3D list(set(fmts) - set(supported_formats(read_on=
ly)))
>               if usf_list:
> -                test_case.case_skip('{}: formats {} are not whitelisted'=
.format(
> -                    test_case, usf_list))
> +                msg =3D f'{test_case}: formats {usf_list} are not whitel=
isted'
> +                test_case.case_skip(msg)
>                   return None
>               else:
>                   return func(test_case, *args, **kwargs)
> diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
> index 8720b6a0de..8d02f00607 100644
> --- a/tests/qemu-iotests/pylintrc
> +++ b/tests/qemu-iotests/pylintrc
> @@ -19,4 +19,8 @@ disable=3Dinvalid-name,
>           too-many-public-methods,
>           # These are temporary, and should be removed:
>           missing-docstring,
> -        line-too-long,
> +
> +[FORMAT]
> +
> +# Maximum number of characters on a single line.
> +max-line-length=3D79
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


