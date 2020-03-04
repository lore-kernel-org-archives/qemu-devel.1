Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62053C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B83820717
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQxsiqr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B83820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9bqT-00005p-BQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54071)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9bpJ-0007Rp-0L
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9bpG-0006ml-FR
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:45:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48285
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9bpG-0006mU-An
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583358310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MdTr2TWUBGGXDKXTxZIpaPHxozp78/KkEvxBU5dHQLk=;
 b=ZQxsiqr4lx4slk+EmubaI2CnPiJUOoTS3bQhlHGjC1MKsofUQ2BtrHYB+pJ6g3aGf4EcAR
 jPAoQEfyavp7cZhSxw3TVpEHTN7N9kMZvqshARAirWPiXA4grBKTct34cmiBpc3SIHMeBs
 Aj5/FTpqAMB470mcYD9Oh/Ik2vOGTUI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-DZOegZfaM76R0gPKCU-zeQ-1; Wed, 04 Mar 2020 16:45:07 -0500
X-MC-Unique: DZOegZfaM76R0gPKCU-zeQ-1
Received: by mail-ed1-f70.google.com with SMTP id u1so2616055edo.14
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 13:45:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bbHyawOfKf8yHvM3+DinKWF/8RMB4VwQ4zNYO71Jwww=;
 b=Zl7HF4chBDYy1FDXJejGLknyFtipEdLB95X080dI0srmdIZdD1NW+ex+bY0tS/lruK
 9e5WAkwiYR/02NTLezUUHFtV3W5RQh4i6GZgrey4xnEh4aroUiXFmT0HSjkzFgquILLX
 u/VL/6V8EYOf23O6/v+RryUxtE8vu2XaAzo896Sr1QZALOmTfI+0EUUt8eBQ6EeodDJh
 RTZxUW3vM0nTOISduo0yFULcK9M1J9OWJP/rhm2lQr5S7p4GFVhbue8tsIULrOGB8uEK
 ZSwjhxwQaFtRVf3/7u79rSMAkcPMgP+/F6QX9+BcF2PKDEgj3MYwErjEdgwMZExaRK/7
 wh1Q==
X-Gm-Message-State: ANhLgQ1XPmOeZuKDihmwa0dI85YVZlbRYYyNTC380aVT9MMU36gWByKU
 tJvLpWGvqKvXINp9uSmDVgPgR5dcqOusGWoy/rbjJO3XYBQFLFqftop0F6tQhZ9bEobFkOO00Ub
 gd/Cet7bv93011uo=
X-Received: by 2002:a05:6402:542:: with SMTP id
 i2mr4807166edx.248.1583358306199; 
 Wed, 04 Mar 2020 13:45:06 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsjLnMWU/XSGHKaTibZua0GC1D060vewJEYTScrCKU4ssFo8S2XaQi8ADkRhvyzVVkPUJ6h5Q==
X-Received: by 2002:a05:6402:542:: with SMTP id
 i2mr4807136edx.248.1583358305802; 
 Wed, 04 Mar 2020 13:45:05 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id t24sm1695949edy.94.2020.03.04.13.45.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2020 13:45:04 -0800 (PST)
Subject: Re: [PATCH v7 01/10] iotests: do a light delinting
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200304213818.15341-1-jsnow@redhat.com>
 <20200304213818.15341-2-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bf9bcd51-3481-259b-5d2a-ede350ceaba0@redhat.com>
Date: Wed, 4 Mar 2020 22:45:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304213818.15341-2-jsnow@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/4/20 10:38 PM, John Snow wrote:
> This doesn't fix everything in here, but it does help clean up the
> pylint report considerably.
>=20
> This should be 100% style changes only; the intent is to make pylint
> more useful by working on establishing a baseline for iotests that we
> can gate against in the future. This will be important if (when?) we
> begin adding type hints to our code base.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 83 ++++++++++++++++++-----------------
>   1 file changed, 43 insertions(+), 40 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 8815052eb5..c3aa857140 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -16,11 +16,9 @@
>   # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   #
>  =20
> -import errno
>   import os
>   import re
>   import subprocess
> -import string
>   import unittest
>   import sys
>   import struct
> @@ -34,7 +32,7 @@
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'py=
thon'))
>   from qemu import qtest
>  =20
> -assert sys.version_info >=3D (3,6)
> +assert sys.version_info >=3D (3, 6)
>  =20
>   # This will not work if arguments contain spaces but is necessary if we
>   # want to support the override options that ./check supports.
> @@ -138,11 +136,11 @@ def qemu_img_log(*args):
>       return result
>  =20
>   def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_a=
rgs=3D[]):
> -    args =3D [ 'info' ]
> +    args =3D ['info']
>       if imgopts:
>           args.append('--image-opts')
>       else:
> -        args +=3D [ '-f', imgfmt ]
> +        args +=3D ['-f', imgfmt]
>       args +=3D extra_args
>       args.append(filename)
>  =20
> @@ -221,7 +219,7 @@ def cmd(self, cmd):
>           # quit command is in close(), '\n' is added automatically
>           assert '\n' not in cmd
>           cmd =3D cmd.strip()
> -        assert cmd !=3D 'q' and cmd !=3D 'quit'
> +        assert cmd not in ('q', 'quit')
>           self._p.stdin.write(cmd + '\n')
>           self._p.stdin.flush()
>           return self._read_output()
> @@ -243,10 +241,8 @@ def qemu_nbd_early_pipe(*args):
>           sys.stderr.write('qemu-nbd received signal %i: %s\n' %
>                            (-exitcode,
>                             ' '.join(qemu_nbd_args + ['--fork'] + list(ar=
gs))))
> -    if exitcode =3D=3D 0:
> -        return exitcode, ''
> -    else:
> -        return exitcode, subp.communicate()[0]
> +
> +    return exitcode, subp.communicate()[0] if exitcode else ''
>  =20
>   def qemu_nbd_popen(*args):
>       '''Run qemu-nbd in daemon mode and return the parent's exit code'''
> @@ -310,7 +306,7 @@ def filter_qmp(qmsg, filter_fn):
>           items =3D qmsg.items()
>  =20
>       for k, v in items:
> -        if isinstance(v, list) or isinstance(v, dict):
> +        if isinstance(v, (dict, list)):
>               qmsg[k] =3D filter_qmp(v, filter_fn)
>           else:
>               qmsg[k] =3D filter_fn(k, v)
> @@ -321,7 +317,7 @@ def filter_testfiles(msg):
>       return msg.replace(prefix, 'TEST_DIR/PID-')
>  =20
>   def filter_qmp_testfiles(qmsg):
> -    def _filter(key, value):
> +    def _filter(_key, value):
>           if is_str(value):
>               return filter_testfiles(value)
>           return value
> @@ -347,7 +343,7 @@ def filter_imgfmt(msg):
>       return msg.replace(imgfmt, 'IMGFMT')
>  =20
>   def filter_qmp_imgfmt(qmsg):
> -    def _filter(key, value):
> +    def _filter(_key, value):
>           if is_str(value):
>               return filter_imgfmt(value)
>           return value
> @@ -358,7 +354,7 @@ def log(msg, filters=3D[], indent=3DNone):
>       If indent is provided, JSON serializable messages are pretty-printe=
d.'''
>       for flt in filters:
>           msg =3D flt(msg)
> -    if isinstance(msg, dict) or isinstance(msg, list):
> +    if isinstance(msg, (dict, list)):
>           # Python < 3.4 needs to know not to add whitespace when pretty-=
printing:
>           separators =3D (', ', ': ') if indent is None else (',', ': ')
>           # Don't sort if it's already sorted
> @@ -369,14 +365,14 @@ def log(msg, filters=3D[], indent=3DNone):
>           print(msg)
>  =20
>   class Timeout:
> -    def __init__(self, seconds, errmsg =3D "Timeout"):
> +    def __init__(self, seconds, errmsg=3D"Timeout"):
>           self.seconds =3D seconds
>           self.errmsg =3D errmsg
>       def __enter__(self):
>           signal.signal(signal.SIGALRM, self.timeout)
>           signal.setitimer(signal.ITIMER_REAL, self.seconds)
>           return self
> -    def __exit__(self, type, value, traceback):
> +    def __exit__(self, exc_type, value, traceback):
>           signal.setitimer(signal.ITIMER_REAL, 0)
>           return False
>       def timeout(self, signum, frame):
> @@ -385,7 +381,7 @@ def timeout(self, signum, frame):
>   def file_pattern(name):
>       return "{0}-{1}".format(os.getpid(), name)
>  =20
> -class FilePaths(object):
> +class FilePaths:
>       """
>       FilePaths is an auto-generated filename that cleans itself up.
>  =20
> @@ -532,11 +528,11 @@ def pause_drive(self, drive, event=3DNone):
>               self.pause_drive(drive, "write_aio")
>               return
>           self.qmp('human-monitor-command',
> -                    command_line=3D'qemu-io %s "break %s bp_%s"' % (driv=
e, event, drive))
> +                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, =
event, drive))
>  =20
>       def resume_drive(self, drive):
>           self.qmp('human-monitor-command',
> -                    command_line=3D'qemu-io %s "remove_break bp_%s"' % (=
drive, drive))
> +                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (dri=
ve, drive))
>  =20
>       def hmp_qemu_io(self, drive, cmd):
>           '''Write to a given drive using an HMP command'''
> @@ -547,8 +543,8 @@ def flatten_qmp_object(self, obj, output=3DNone, base=
str=3D''):
>           if output is None:
>               output =3D dict()
>           if isinstance(obj, list):
> -            for i in range(len(obj)):
> -                self.flatten_qmp_object(obj[i], output, basestr + str(i)=
 + '.')
> +            for i, atom in enumerate(obj):
> +                self.flatten_qmp_object(atom, output, basestr + str(i) +=
 '.')
>           elif isinstance(obj, dict):
>               for key in obj:
>                   self.flatten_qmp_object(obj[key], output, basestr + key=
 + '.')
> @@ -703,9 +699,7 @@ def get_bitmap(self, node_name, bitmap_name, recordin=
g=3DNone, bitmaps=3DNone):
>  =20
>           for bitmap in bitmaps[node_name]:
>               if bitmap.get('name', '') =3D=3D bitmap_name:
> -                if recording is None:
> -                    return bitmap
> -                elif bitmap.get('recording') =3D=3D recording:
> +                if recording is None or bitmap.get('recording') =3D=3D r=
ecording:
>                       return bitmap
>           return None
>  =20
> @@ -756,12 +750,13 @@ def assert_block_path(self, root, path, expected_no=
de, graph=3DNone):
>               assert node is not None, 'Cannot follow path %s%s' % (root,=
 path)
>  =20
>               try:
> -                node_id =3D next(edge['child'] for edge in graph['edges'=
] \
> -                                             if edge['parent'] =3D=3D no=
de['id'] and
> -                                                edge['name'] =3D=3D chil=
d_name)
> +                node_id =3D next(edge['child'] for edge in graph['edges'=
]
> +                               if (edge['parent'] =3D=3D node['id'] and
> +                                   edge['name'] =3D=3D child_name))
> +
> +                node =3D next(node for node in graph['nodes']
> +                            if node['id'] =3D=3D node_id)
>  =20
> -                node =3D next(node for node in graph['nodes'] \
> -                                 if node['id'] =3D=3D node_id)
>               except StopIteration:
>                   node =3D None
>  =20
> @@ -779,6 +774,12 @@ def assert_block_path(self, root, path, expected_nod=
e, graph=3DNone):
>   class QMPTestCase(unittest.TestCase):
>       '''Abstract base class for QMP test cases'''
>  =20
> +    def __init__(self, *args, **kwargs):
> +        super().__init__(*args, **kwargs)
> +        # Many users of this class set a VM property we rely on heavily
> +        # in the methods below.
> +        self.vm =3D None
> +
>       def dictpath(self, d, path):
>           '''Traverse a path in a nested dict'''
>           for component in path.split('/'):
> @@ -824,7 +825,7 @@ def assert_qmp(self, d, path, value):
>           else:
>               self.assertEqual(result, value,
>                                '"%s" is "%s", expected "%s"'
> -                                 % (path, str(result), str(value)))
> +                             % (path, str(result), str(value)))
>  =20
>       def assert_no_active_block_jobs(self):
>           result =3D self.vm.qmp('query-block-jobs')
> @@ -834,15 +835,15 @@ def assert_has_block_node(self, node_name=3DNone, f=
ile_name=3DNone):
>           """Issue a query-named-block-nodes and assert node_name and/or
>           file_name is present in the result"""
>           def check_equal_or_none(a, b):
> -            return a =3D=3D None or b =3D=3D None or a =3D=3D b
> +            return a is None or b is None or a =3D=3D b
>           assert node_name or file_name
>           result =3D self.vm.qmp('query-named-block-nodes')
>           for x in result["return"]:
>               if check_equal_or_none(x.get("node-name"), node_name) and \
>                       check_equal_or_none(x.get("file"), file_name):
>                   return
> -        self.assertTrue(False, "Cannot find %s %s in result:\n%s" % \
> -                (node_name, file_name, result))
> +        self.fail("Cannot find %s %s in result:\n%s" %
> +                  (node_name, file_name, result))
>  =20
>       def assert_json_filename_equal(self, json_filename, reference):
>           '''Asserts that the given filename is a json: filename and that=
 its
> @@ -891,13 +892,13 @@ def wait_until_completed(self, drive=3D'drive0', ch=
eck_offset=3DTrue, wait=3D60.0,
>                           self.assert_qmp(event, 'data/error', error)
>                       self.assert_no_active_block_jobs()
>                       return event
> -                elif event['event'] =3D=3D 'JOB_STATUS_CHANGE':
> +                if event['event'] =3D=3D 'JOB_STATUS_CHANGE':

I don't understand the rational for this change, but the result is=20
correct anyway, so thanks for this nice cleanup!

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>                       self.assert_qmp(event, 'data/id', drive)
>  =20
>       def wait_ready(self, drive=3D'drive0'):
> -        '''Wait until a block job BLOCK_JOB_READY event'''
> -        f =3D {'data': {'type': 'mirror', 'device': drive } }
> -        event =3D self.vm.event_wait(name=3D'BLOCK_JOB_READY', match=3Df=
)
> +        """Wait until a BLOCK_JOB_READY event, and return the event."""
> +        f =3D {'data': {'type': 'mirror', 'device': drive}}
> +        return self.vm.event_wait(name=3D'BLOCK_JOB_READY', match=3Df)
>  =20
>       def wait_ready_and_cancel(self, drive=3D'drive0'):
>           self.wait_ready(drive=3Ddrive)
> @@ -926,7 +927,7 @@ def pause_wait(self, job_id=3D'job0'):
>                   for job in result['return']:
>                       if job['device'] =3D=3D job_id:
>                           found =3D True
> -                        if job['paused'] =3D=3D True and job['busy'] =3D=
=3D False:
> +                        if job['paused'] and not job['busy']:
>                               return job
>                           break
>                   assert found
> @@ -1023,8 +1024,8 @@ def qemu_pipe(*args):
>                               universal_newlines=3DTrue)
>       exitcode =3D subp.wait()
>       if exitcode < 0:
> -        sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode,
> -                         ' '.join(args)))
> +        sys.stderr.write('qemu received signal %i: %s\n' %
> +                         (-exitcode, ' '.join(args)))
>       return subp.communicate()[0]
>  =20
>   def supported_formats(read_only=3DFalse):
> @@ -1056,6 +1057,7 @@ def func_wrapper(test_case: QMPTestCase, *args, **k=
wargs):
>               if usf_list:
>                   test_case.case_skip('{}: formats {} are not whitelisted=
'.format(
>                       test_case, usf_list))
> +                return None
>               else:
>                   return func(test_case, *args, **kwargs)
>           return func_wrapper
> @@ -1067,6 +1069,7 @@ def skip_if_user_is_root(func):
>       def func_wrapper(*args, **kwargs):
>           if os.getuid() =3D=3D 0:
>               case_notrun('{}: cannot be run as root'.format(args[0]))
> +            return None
>           else:
>               return func(*args, **kwargs)
>       return func_wrapper
>=20


