Received: from eggs.gnu.org ([2001:4830:134:3::10]:32947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqm6h-0004mY-32
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqm6d-0004sX-4v
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:39:43 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqm6c-0004sK-Vr
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 15:39:39 -0400
Received: by mail-qt0-x243.google.com with SMTP id n37so26663394qtb.3
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 12:39:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<c46ff864-fc8b-aeba-30f4-4c773f879786@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85b94581-70ec-3e7e-1f2f-dd70204fb68c@amsat.org>
Date: Wed, 22 Mar 2017 16:39:34 -0300
MIME-Version: 1.0
In-Reply-To: <c46ff864-fc8b-aeba-30f4-4c773f879786@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] rawhide gcc failures [was: Proposal for
 deprecating unsupported host OSes & architecutures]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

so lovely...

as a start point for bleeding edge stuff this can go in CI as a 
complement of debian images in tests/docker/... using the official 
fedora:rawhide base image.

On 03/22/2017 04:07 PM, Eric Blake wrote:
> On 03/16/2017 10:23 AM, Peter Maydell wrote:
>> OK, here's a concrete proposal for deprecating/dropping out of
>> date host OS and architecture support.
>>
>> We'll put this in the ChangeLog 'Future incompatible changes'
>> section:
>> -----
>> * Removal of support for untested host OS and architectures:
>
> Tangentially-related: do we officially support bleeding-edge OS builds?
> For example, current rawhide has a new-enough gcc that gives some
> (possibly-useful) new warnings (-Werror=format-truncation) that fire
> when formatting what can be easily proven to be larger than a
> fixed-width buffer will hold.  If rawhide is not a current target, then
> I don't need to spend any time on this (yet); but if rawhide builds ARE
> supported, then we want this patched before 2.9:
>
>
>   CC      block/blkdebug.o
> block/blkdebug.c: In function ‘blkdebug_refresh_filename’:
> block/blkdebug.c:693:31: error: ‘%s’ directive output may be truncated
> writing up to 4095 bytes into a region of size 4086
> [-Werror=format-truncation=]
>                   "blkdebug:%s:%s", s->config_file ?: "",
>                                ^~
> block/blkdebug.c:692:9: note: ‘snprintf’ output 11 or more bytes
> (assuming 4106) into a destination of size 4096
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   "blkdebug:%s:%s", s->config_file ?: "",
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   bs->file->bs->exact_filename);
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dummy/qemu/rules.mak:69: block/blkdebug.o] Error 1
>   CC      block/blkverify.o
> block/blkverify.c: In function ‘blkverify_refresh_filename’:
> block/blkverify.c:309:29: error: ‘%s’ directive output may be truncated
> writing up to 4095 bytes into a region of size 4086
> [-Werror=format-truncation=]
>                   "blkverify:%s:%s",
>                              ^~
> block/blkverify.c:308:9: note: ‘snprintf’ output between 12 and 8202
> bytes into a destination of size 4096
>          snprintf(bs->exact_filename, sizeof(bs->exact_filename),
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   "blkverify:%s:%s",
>                   ~~~~~~~~~~~~~~~~~~
>                   bs->file->bs->exact_filename,
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   s->test_file->bs->exact_filename);
>                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dummy/qemu/rules.mak:69: block/blkverify.o] Error 1
>   CC      hw/usb/bus.o
> hw/usb/bus.c: In function ‘usb_port_location’:
> hw/usb/bus.c:410:66: error: ‘%d’ directive output may be truncated
> writing between 1 and 11 bytes into a region of size between 0 and 15
> [-Werror=format-truncation=]
>          snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
>                                                                   ^~
> hw/usb/bus.c:410:9: note: ‘snprintf’ output between 3 and 28 bytes into
> a destination of size 16
>          snprintf(downstream->path, sizeof(downstream->path), "%s.%d",
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>                   upstream->path, portnr);
>                   ~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dummy/qemu/rules.mak:69: hw/usb/bus.o] Error 1
>   CC      net/slirp.o
> net/slirp.c: In function ‘slirp_smb_cleanup’:
> net/slirp.c:565:44: error: ‘%s’ directive output may be truncated
> writing up to 127 bytes into a region of size 121
> [-Werror=format-truncation=]
>          snprintf(cmd, sizeof(cmd), "rm -rf %s", s->smb_dir);
>                                             ^~
> net/slirp.c:565:9: note: ‘snprintf’ output between 8 and 135 bytes into
> a destination of size 128
>          snprintf(cmd, sizeof(cmd), "rm -rf %s", s->smb_dir);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/slirp.c: In function ‘slirp_smb’:
> net/slirp.c:609:46: error: ‘%s’ directive output may be truncated
> writing 8 bytes into a region of size between 0 and 127
> [-Werror=format-truncation=]
>      snprintf(smb_conf, sizeof(smb_conf), "%s/%s", s->smb_dir, "smb.conf");
>                                               ^~               ~~~~~~~~~~
> net/slirp.c:609:5: note: ‘snprintf’ output between 10 and 137 bytes into
> a destination of size 128
>      snprintf(smb_conf, sizeof(smb_conf), "%s/%s", s->smb_dir, "smb.conf");
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/slirp.c:654:55: error: ‘%s’ directive output may be truncated
> writing up to 127 bytes into a region of size 110
> [-Werror=format-truncation=]
>      snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
>                                                        ^~
> net/slirp.c:654:5: note: ‘snprintf’ output 23 or more bytes (assuming
> 150) into a destination of size 128
>      snprintf(smb_cmdline, sizeof(smb_cmdline), "%s -l %s -s %s",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>               CONFIG_SMBD_COMMAND, s->smb_dir, smb_conf);
>               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make: *** [/home/dummy/qemu/rules.mak:69: net/slirp.o] Error 1
> make: Target 'all' not remade because of errors.
>
>
