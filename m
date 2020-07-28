Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51589C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0CA2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 16:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpCHIFkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0CA2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0S7U-0007i4-CD
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 12:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k0S6l-0006tL-5s
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:05:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21192
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k0S6h-0008S6-VW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 12:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595952334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bOebxCoEn0DcfuvxjNfVXlJz9FhGJZSVlqSJdGnoS/I=;
 b=QpCHIFkvc1V9Gvv1NuLfFolpVZ/eoaJf83b2evWKOD5boKnpjxxiAEcb9pKFAZjhWLyVOV
 AzylHtxnp/FPM3ofxVTsHt76K3mHnPT0GqWgaURoiyshnndUgkpR5/7j36cDgrbhyU0n7b
 XrtPgZpnYFzrVLP9wZQDbCLqYUQ7Pwo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-mmW8K5G0O3q2OigmRrxoog-1; Tue, 28 Jul 2020 12:05:32 -0400
X-MC-Unique: mmW8K5G0O3q2OigmRrxoog-1
Received: by mail-oi1-f197.google.com with SMTP id r62so10722160oif.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 09:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bOebxCoEn0DcfuvxjNfVXlJz9FhGJZSVlqSJdGnoS/I=;
 b=l2PlZrPo/cfcQOzw73h5pF+amyPf0bD+fNHhRavQR4h1IUO3KtS9GSmMWJZDL1jBSv
 uu+74gAvCLbHeNWagsprkedNZx2VFJ5PU61/4p8EX3IlIXRzETZxX7SdDpCQTX6acilo
 EOx6EAY6wbqqfm4JAIDZ6mH1alcSXa3qCSUTfNBHx1MOsuX7ehPOvIIdgTCu4Q/jB9Th
 FHR7WOPUhqIDFfuyGkDE5e1s2zIG9QKYr7WTk5QY4emO5HRTVTeLh26fzw68i0RrM/Qv
 QgBPyI6nU2BLbeBGvzcUas0kLb9IRqFuZq5GFQx0nU6IyJfzAeTMDGfcIU17UD/1S0Ib
 y9TQ==
X-Gm-Message-State: AOAM532kE86CCJMCWcgxuKLOkNOdrxPOu8x6/7jHd+99v/BSz8knhH6z
 2F6qb+UPu+hQiS6xT19tFJNT8FyVUPDvkNh9wPsrsq8u4pJP9snRHMhYXUU3Q3krPBBVj50mHzc
 R5yzAQUH6Xtx/i0pjM97pZ1b2XVrDnug=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr25071849otq.81.1595952331176; 
 Tue, 28 Jul 2020 09:05:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcse7NmRyTKQeTm+Zz1ktD/6wUHXO6X7kUAyjZEd0sx8Zif0jCe70EP9kRNIiLSRZC8pTX4iME75MA4tOtJnk=
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr25071809otq.81.1595952330765; 
 Tue, 28 Jul 2020 09:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200727215846.395443-1-nsoffer@redhat.com>
 <20200727215846.395443-3-nsoffer@redhat.com>
 <ac8994e8-7f06-0710-78ce-0596e9538e7d@virtuozzo.com>
In-Reply-To: <ac8994e8-7f06-0710-78ce-0596e9538e7d@virtuozzo.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 28 Jul 2020 19:05:14 +0300
Message-ID: <CAMRbyyuz5yfbuQHJDNXcdbW=pdyH8rSqM6um=XkaDtH1gpk9dg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] iotests: Make qemu_nbd_popen() a contextmanager
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 28, 2020 at 4:43 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> 28.07.2020 00:58, Nir Soffer wrote:
> > Instead of duplicating the code to wait until the server is ready and
> > remember to terminate the server and wait for it, make it possible to
> > use like this:
> >
> >      with qemu_nbd_popen('-k', sock, image):
> >          # Access image via qemu-nbd socket...
> >
> > Only test 264 used this helper, but I had to modify the output since it
> > did not consistently when starting and stopping qemu-nbd.
> >
> > Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> > ---
> >   tests/qemu-iotests/264        | 76 +++++++++++++----------------------
> >   tests/qemu-iotests/264.out    |  2 +
> >   tests/qemu-iotests/iotests.py | 28 ++++++++++++-
> >   3 files changed, 56 insertions(+), 50 deletions(-)
> >
> > diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
> > index 304a7443d7..666f164ed8 100755
> > --- a/tests/qemu-iotests/264
> > +++ b/tests/qemu-iotests/264
> > @@ -36,48 +36,32 @@ wait_step = 0.2
> >
> >   qemu_img_create('-f', iotests.imgfmt, disk_a, str(size))
> >   qemu_img_create('-f', iotests.imgfmt, disk_b, str(size))
> > -srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
> >
> > -# Wait for NBD server availability
> > -t = 0
> > -ok = False
> > -while t < wait_limit:
> > -    ok = qemu_io_silent_check('-f', 'raw', '-c', 'read 0 512', nbd_uri)
> > -    if ok:
> > -        break
> > -    time.sleep(wait_step)
> > -    t += wait_step
> > +with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
> > +    vm = iotests.VM().add_drive(disk_a)
> > +    vm.launch()
> > +    vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
> > +
> > +    vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
> > +               **{'node_name': 'backup0',
> > +                  'driver': 'raw',
> > +                  'file': {'driver': 'nbd',
> > +                           'server': {'type': 'unix', 'path': nbd_sock},
> > +                           'reconnect-delay': 10}})
> > +    vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
> > +               speed=(1 * 1024 * 1024))
> > +
> > +    # Wait for some progress
> > +    t = 0
> > +    while t < wait_limit:
> > +        jobs = vm.qmp('query-block-jobs')['return']
> > +        if jobs and jobs[0]['offset'] > 0:
> > +            break
> > +        time.sleep(wait_step)
> > +        t += wait_step
> >
> > -assert ok
> > -
> > -vm = iotests.VM().add_drive(disk_a)
> > -vm.launch()
> > -vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
> > -
> > -vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
> > -           **{'node_name': 'backup0',
> > -              'driver': 'raw',
> > -              'file': {'driver': 'nbd',
> > -                       'server': {'type': 'unix', 'path': nbd_sock},
> > -                       'reconnect-delay': 10}})
> > -vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
> > -           speed=(1 * 1024 * 1024))
> > -
> > -# Wait for some progress
> > -t = 0
> > -while t < wait_limit:
> > -    jobs = vm.qmp('query-block-jobs')['return']
> >       if jobs and jobs[0]['offset'] > 0:
> > -        break
> > -    time.sleep(wait_step)
> > -    t += wait_step
> > -
> > -if jobs and jobs[0]['offset'] > 0:
> > -    log('Backup job is started')
> > -
> > -log('Kill NBD server')
> > -srv.kill()
> > -srv.wait()
> > +        log('Backup job is started')
> >
> >   jobs = vm.qmp('query-block-jobs')['return']
> >   if jobs and jobs[0]['offset'] < jobs[0]['len']:
> > @@ -88,12 +72,8 @@ vm.qmp_log('block-job-set-speed', device='drive0', speed=0)
> >   # Emulate server down time for 1 second
> >   time.sleep(1)
> >
> > -log('Start NBD server')
> > -srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
> > -
> > -e = vm.event_wait('BLOCK_JOB_COMPLETED')
> > -log('Backup completed: {}'.format(e['data']['offset']))
> > -
> > -vm.qmp_log('blockdev-del', node_name='backup0')
> > -srv.kill()
> > -vm.shutdown()
> > +with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
> > +    e = vm.event_wait('BLOCK_JOB_COMPLETED')
> > +    log('Backup completed: {}'.format(e['data']['offset']))
> > +    vm.qmp_log('blockdev-del', node_name='backup0')
> > +    vm.shutdown()
> > diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
> > index 3000944b09..c45b1e81ef 100644
> > --- a/tests/qemu-iotests/264.out
> > +++ b/tests/qemu-iotests/264.out
> > @@ -1,3 +1,4 @@
> > +Start NBD server
> >   {"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
> >   {"return": {}}
> >   {"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": 1048576, "sync": "full", "target": "backup0"}}
> > @@ -11,3 +12,4 @@ Start NBD server
> >   Backup completed: 5242880
> >   {"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
> >   {"return": {}}
> > +Kill NBD server
> > diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> > index 3590ed78a0..8f79668435 100644
> > --- a/tests/qemu-iotests/iotests.py
> > +++ b/tests/qemu-iotests/iotests.py
> > @@ -28,10 +28,13 @@ import signal
> >   import struct
> >   import subprocess
> >   import sys
> > +import time
> >   from typing import (Any, Callable, Dict, Iterable,
> >                       List, Optional, Sequence, Tuple, TypeVar)
> >   import unittest
> >
> > +from contextlib import contextmanager
> > +
> >   # pylint: disable=import-error, wrong-import-position
> >   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
> >   from qemu import qtest
> > @@ -270,9 +273,30 @@ def qemu_nbd_early_pipe(*args):
> >
> >       return subp.returncode, output if subp.returncode else ''
> >
> > +@contextmanager
> >   def qemu_nbd_popen(*args):
> > -    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
> > -    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
> > +    '''Context manager running qemu-nbd within the context'''
>
> PEP8 (or some another PEP referenced in PEP8) asks to use """ for doc-strings

Both are valid, but I agree that """ is nicer.

This module needs more work:

$ flake8 --statistics --quiet tests/qemu-iotests/iotests.py
tests/qemu-iotests/iotests.py
1     E261 at least two spaces before inline comment
3     E301 expected 1 blank line, found 0
64    E302 expected 2 blank lines, found 1
1     E303 too many blank lines (2)
5     E305 expected 2 blank lines after class or function definition, found 1
2     E402 module level import not at top of file

> > +    pid_file = file_path("pid")
> > +
> > +    cmd = list(qemu_nbd_args)
> > +    cmd.extend(('--persistent', '--pid-file', pid_file))
> > +    cmd.extend(args)
> > +
> > +    log('Start NBD server')
> > +    p = subprocess.Popen(cmd)
> > +    try:
> > +        while not os.path.exists(pid_file):
> > +            if p.poll() is not None:
> > +                raise RuntimeError(
> > +                    "qemu-nbd terminated with exit code {}: {}"
> > +                    .format(p.returncode, ' '.join(cmd)))
> > +
> > +            time.sleep(0.01)
> > +        yield
> > +    finally:
> > +        log('Kill NBD server')
> > +        p.kill()
> > +        p.wait()
>
> why do we need try-finally? I think, the only possible exception is your "raise RuntimeError", and in this case the process is alredy dead, no need to kill it (and print the log message)

The try-finally is needed for errors in user code like:

    with qemu_nbd_popen():
         assert 0

Without try-finally qemu-nbd will continue to run after the assert
fails, which may
cause trouble, depending on the test.

In the case of the RuntimeError inside the try, the cleanup in finally is
not needed but harmless.

Looking in python source:

        def send_signal(self, sig):
            """Send a signal to the process."""
            # Skip signalling a process that we know has already died.
            if self.returncode is None:
                os.kill(self.pid, sig)

        def kill(self):
            """Kill the process with SIGKILL
            """
            self.send_signal(signal.SIGKILL)

So the kill() will do nothing, and wait() will return immediately.

> >   def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
> >       '''Return True if two image files are identical'''
> >
>
> anyway:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> --
> Best regards,
> Vladimir
>


