Received: from eggs.gnu.org ([2001:4830:134:3::10]:55204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlFLN-0000Kp-7r
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlFLK-0007LX-08
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:12:17 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dlFLJ-0007L2-PR
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:12:13 -0400
Received: by mail-wm0-x244.google.com with SMTP id e67so2740562wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 07:12:13 -0700 (PDT)
Date: Fri, 25 Aug 2017 15:12:10 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170825141210.GA11641@stefanha-x1.localdomain>
References: <1503493480-21691-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1503493480-21691-2-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503493480-21691-2-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 1/3] backup: QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

On Wed, Aug 23, 2017 at 06:34:38PM +0530, Ishani Chugh wrote:
> +    def write_config(self):
> +        """
> +        Writes configuration to ini file.
> +        """
> +        config_file = open(self.config_file+".tmp", 'w')

Please use whitespace around arithmetic operators:

  self.config_file + ".tmp"

> +        self.config.write(config_file)
> +        config_file.flush()
> +        os.fsync(config_file.fileno())
> +        config_file.close()
> +        os.rename(self.config_file+".tmp", self.config_file)

self.config_file + ".tmp"

> +
> +    def get_socket_address(self, socket_address):
> +        """
> +        Return Socket address in form of string or tuple
> +        """
> +        if socket_address.startswith('tcp'):
> +            return (socket_address.split(':')[1],
> +                    int(socket_address.split(':')[2]))
> +        return socket_address.split(':', 2)[1]
> +
> +    def _full_backup(self, guest_name):
> +        """
> +        Performs full backup of guest
> +        """
> +        if guest_name not in self.config.sections():
> +            print("Cannot find specified guest", file=sys.stderr)
> +            sys.exit(1)
> +
> +        self.verify_guest_running(guest_name)
> +        connection = QEMUMonitorProtocol(
> +                                         self.get_socket_address(
> +                                             self.config[guest_name]['qmp']))
> +        connection.connect()
> +        cmd = {"execute": "transaction", "arguments": {"actions": []}}
> +        drive_list = []
> +        for key in self.config[guest_name]:
> +            if key.startswith("drive_"):
> +                drive = key[len('drive_'):]
> +                drive_list.append(drive)
> +                target = self.config[guest_name][key]
> +                sub_cmd = {"type": "drive-backup", "data": {"device": drive,
> +                                                            "target": target,
> +                                                            "sync": "full"}}
> +                cmd['arguments']['actions'].append(sub_cmd)
> +        qmp_return = connection.cmd_obj(cmd)
> +        if 'error' in qmp_return:
> +            print(qmp_return['error']['desc'], file=sys.stderr)
> +            sys.exit(1)
> +        print("Backup Started")
> +        while len(drive_list) != 0:

PEP8 says:

  For sequences, (strings, lists, tuples), use the fact that empty sequences are false.

  Yes: if not seq:
       if seq:

  No: if len(seq):
      if not len(seq):

This statement should be:

  while drive_list:

> +            event = connection.pull_event(wait=True)
> +            print(event)

Please remove debugging or add a --verbose command-line option that
makes the print statement conditional:

  if verbose:
      print(event)

> +            if event['event'] == 'SHUTDOWN':
> +                print("The guest was SHUT DOWN", file=sys.stderr)
> +                sys.exit(1)
> +
> +            if event['event'] == 'RESET':
> +                print("The guest was Rebooted", file=sys.stderr)
> +                sys.exit(1)

I think you found this is a soft reset and the blockjob is still
running.  There is no need to exit.  You can ignore this event.

> +
> +            if event['event'] == 'BLOCK_JOB_COMPLETED':
> +                if event['data']['device'] in drive_list and \
> +                        event['data']['type'] == 'backup':
> +                        print("*"+event['data']['device'])

Please use whitespace around arithmetic operators:

  print("*" + event['data']['device'])

> +                        drive_list.remove(event['data']['device'])
> +
> +            if event['event'] == 'BLOCK_JOB_ERROR':
> +                if event['data']['device'] in drive_list and \
> +                        event['data']['type'] == 'backup':
> +                        print(event['data']['device']+" Backup Failed", file=sys.stderr)

The drive was not removed from drive_list so the loop never terminates.

sys.exit(1)?
