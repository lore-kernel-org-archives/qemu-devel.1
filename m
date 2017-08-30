Received: from eggs.gnu.org ([2001:4830:134:3::10]:55429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn4Yj-0007SR-GB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn4Yf-0006CR-56
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:05:37 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:38055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn4Ye-0006CH-Tr
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 11:05:33 -0400
Received: by mail-wr0-x229.google.com with SMTP id 40so18780929wrv.5
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 08:05:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1198198789.1361162.1504105075026.JavaMail.zimbra@research.iiit.ac.in>
References: <1504025019-16820-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504025019-16820-2-git-send-email-chugh.ishani@research.iiit.ac.in>
	<20170830042133.GG4208@lemon.lan>
	<1198198789.1361162.1504105075026.JavaMail.zimbra@research.iiit.ac.in>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 30 Aug 2017 16:05:30 +0100
Message-ID: <CAJSP0QWvOoRpNmSsw-V6jVjcc6Eyf=rSH_Qjpe3uGNAT5C7q6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] backup: QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani <chugh.ishani@research.iiit.ac.in>
Cc: Fam Zheng <famz@redhat.com>, jsnow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, stefanha <stefanha@redhat.com>

On Wed, Aug 30, 2017 at 3:57 PM, Ishani
<chugh.ishani@research.iiit.ac.in> wrote:
> ----- On Aug 30, 2017, at 9:51 AM, Fam Zheng famz@redhat.com wrote:
>
>> On Tue, 08/29 22:13, Ishani Chugh wrote:
>>> +class BackupTool(object):
>>> +    """BackupTool Class"""
>>> +    def __init__(self, config_file=os.path.expanduser('~') +
>>> +                 '/.config/qemu/qemu-backup-config'):
>>> +        if "QEMU_BACKUP_CONFIG" in os.environ:
>>> +            self.config_file = os.environ["QEMU_BACKUP_CONFIG"]
>>> +        else:
>>> +            self.config_file = config_file
>>> +            try:
>>> +                if not os.path.isdir(os.path.dirname(self.config_file)):
>>> +                    os.makedirs(os.path.dirname(self.config_file))
>>> +            except:
>>> +                print("Cannot create config directory", file=sys.stderr)
>>> +                sys.exit(1)
>>> +        self.config = configparser.ConfigParser()
>>> +        self.config.read(self.config_file)
>>
>> I suggest adding versioning to the config file, so that a future update to this
>> tool can make an incompatible change without breaking older tool:
>>
>> [general]
>> version=0.1
>>
>> [guest_1]
>> ...
>>
>> [guest_2]
>> ...
>>
>> And only continue if the version is known.
>>
>> Fam
>
> I could not understand the intention behind adding versioning to config file.
> Can you please elaborate a little on what is meant by incompatible change?

If a new feature is added to qemu-backup in the future then it's
possible a user might have 2 machines, one with the old qemu-backup
version and one with the new qemu-backup.

When the new qemu-backup adds things to the configuration file the old
qemu-backup wouldn't know (because the code only queries the
configuration parameters it knows about).  Running the old qemu-backup
again could conflict with the new configuration.

Fam is suggesting putting a version number into the configuration
file.  This way the old qemu-backup can refuse to run with a newer
configuration file.

It also makes it possible for a new qemu-backup to detect that the
last run was with an older version so it can upgrade the configuration
file, if necessary.

Stefan
