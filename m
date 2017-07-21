Received: from eggs.gnu.org ([2001:4830:134:3::10]:36600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYabK-0008I9-JO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYabH-00039x-Da
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:16:26 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:34883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYabH-00039P-2x
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 12:16:23 -0400
Received: by mail-wm0-x235.google.com with SMTP id w126so16612810wme.0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 09:16:22 -0700 (PDT)
References: <1500151401-30863-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170717071835.GD22872@lemon>
	<1805860107.204084.1500320230836.JavaMail.zimbra@research.iiit.ac.in>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1805860107.204084.1500320230836.JavaMail.zimbra@research.iiit.ac.in>
Date: Fri, 21 Jul 2017 17:16:19 +0100
Message-ID: <87lgnh7oks.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC] RFC on Backup tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani <chugh.ishani@research.iiit.ac.in>
Cc: Fam Zheng <famz@redhat.com>, jsnow <jsnow@redhat.com>, qemu-devel@nongnu.org, stefanha <stefanha@redhat.com>


Ishani <chugh.ishani@research.iiit.ac.in> writes:

> Thanks for the review.
>
> ----- On Jul 17, 2017, at 12:48 PM, Fam Zheng famz@redhat.com wrote:
>
>> On Sun, 07/16 02:13, Ishani Chugh wrote:
>>> This is a Request For Comments patch for qemu backup tool. As an
>>> Outreachy intern, I am assigned to the project for creating a backup
>>> tool. qemu-backup will be a command-line tool for performing full and
>>> incremental disk backups on running VMs.
>>
>> Only full backup is implemented in this patch, is the plan to add incremental
>> backup on top?  I'm curious because you have target file path set during drive
>> add, but in the incremental case, it should be possible that each backup creates
>> a new target file that chains up with earlier ones, so I think the target file
>> should be an option for "backup" command as well.
>
> Yes. Incremental backup is to be added. I am still in learning phase with
> respect to incremental backups. I will modify the arguments and workflow accordingly.
>
>>> It is intended as a
>>> reference implementation for management stack and backup developers
>>> to see QEMU's backup features in action. The tool writes details of
>>> guest in a configuration file and the data is retrieved from the file
>>> while creating a backup. The usage is as follows:
>>> Add a guest
>>> python qemu-backup.py guest add --guest <guest_name> --qmp <socket_path> [--tcp]
>>>
>>> Add a drive for backup in a specified guest
>>> python qemu-backup.py drive add --guest <guest_name> --id <drive_id> [--target
>>> <target_file_path>]
>>>
>>> Create backup of the added drives:
>>> python qemu-backup.py backup --guest <guest_name>
>>>
>>> List all guest configs in configuration file:
>>> python qemu-backup.py guest list
>>
>> Please put these examples into the help output of the command, this way users
>> can read it as well.
>
> I have created a manpage documentation for the tool.
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg05241.html
> It is to be updated continuously as the development progresses.
>
>>>
>>> I will be obliged by any feedback.
>>
>> Thanks for doing this!
>>
>>>
>>> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
>>> ---
>>>  contrib/backup/qemu-backup.py | 244 ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 244 insertions(+)
>>>  create mode 100644 contrib/backup/qemu-backup.py
>>>
>>> diff --git a/contrib/backup/qemu-backup.py b/contrib/backup/qemu-backup.py
>>> new file mode 100644
>>> index 0000000..9c3dc53
>>> --- /dev/null
>>> +++ b/contrib/backup/qemu-backup.py
>>> @@ -0,0 +1,244 @@
>>> +#!/usr/bin/python
>>> +# -*- coding: utf-8 -*-
>>
>> You need a copyright header here (the default choice for QEMU is GPLv2 but there
>> is no strict restrictions for scripts). See examples in other *.py files.
>
> Thanks. Will update in next revision.
>
>>> +"""
>>> +This file is an implementation of backup tool
>>> +"""
>>> +from argparse import ArgumentParser
>>> +import os
>>> +import errno
>>> +from socket import error as socket_error
>>> +import configparser
>>
>> Python2 has ConfigParser while python3 has configparser. Please be specific
>> about the python compatibility level of this script - my system (Fedora) has
>> python2 as /usr/bin/python, so the shebang and your example command in the
>> commit message don't really work. "six" module can handle python 2/3
>> differentiations, or you can use '#!/usr/bin/env python2' to specify a python
>> version explicitly.
>
> The script is supposed to be both python2/3 compatible. I will take reference
> from Stefan's review and fix it in next revision.
>
>>> +import sys
>>> +sys.path.append('../../scripts/qmp')
>>
>> This expects the script to be invoked from its local directory? It's better to
>> use the __file__ trick to allow arbitrary workdir:
>>
>> $ git grep __file__
>> scripts/device-crash-test:sys.path.append(os.path.join(os.path.dirname(__file__),
>> '..', 'scripts'))
>> scripts/qemu-gdb.py:sys.path.append(os.path.dirname(__file__))
>> tests/migration/guestperf/engine.py:sys.path.append(os.path.join(os.path.dirname(__file__),
>> '..', '..', '..', 'scripts'))
>> tests/qemu-iotests/iotests.py:sys.path.append(os.path.join(os.path.dirname(__file__),
>> '..', '..', 'scripts'))
>
> Thanks. Will fix it in next revision.
>
>>> +from qmp import QEMUMonitorProtocol
>>> +
>>> +
>>> +class BackupTool(object):
>>> +    """BackupTool Class"""
>>> +    def __init__(self, config_file='backup.ini'):
>>
>> Is it better to put this in a more predictable place such as
>> "$HOME/.qemu-backup.ini" and/or make it a command line option?
>
> It is planned to be an optional command-line option, if not
> provided, the default location suggested should be taken.

Can it be $HOME/.config/qemu/backup.ini please as per:

  https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

Cheers,

--
Alex Bennée
