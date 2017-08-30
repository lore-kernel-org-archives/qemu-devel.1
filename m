Received: from eggs.gnu.org ([2001:4830:134:3::10]:45238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmuPs-0006bg-O6
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmuPr-0003aK-Ga
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dmuPr-0003a9-AU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 00:15:47 -0400
Date: Wed, 30 Aug 2017 12:15:39 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170830041539.GF4208@lemon.lan>
References: <1504025019-16820-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504025019-16820-2-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504025019-16820-2-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] backup: QEMU Backup Tool
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

On Tue, 08/29 22:13, Ishani Chugh wrote:
> +    def _restore(self, guest_name):
> +        """
> +        Prints Steps to perform restore operation
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
> +        print("To perform restore:")
> +        print("Shut down guest")
> +        for key in self.config[guest_name]:
> +            if key.startswith("drive_"):
> +                drive = key[len('drive_'):]
> +                target = self.config[guest_name][key]
> +                cmd = {'execute': 'query-block'}
> +                returned_json = connection.cmd_obj(cmd)
> +                device_present = False
> +                for device in returned_json['return']:
> +                    if device['device'] == drive:
> +                        device_present = True
> +                        location = device['inserted']['image']['filename']
> +                        print("Replace " + location + " By " + target)

Maybe just

    print("qemu-img convert " + location + " " + target)

which is almost ready to copy&paste into a command line? (You or the user needs
take care of quoting and escaping to handle the special characters, if any.)

> +
> +                if not device_present:
> +                    print("No such drive in guest", file=sys.stderr)
> +                    sys.exit(1)
> +

Fam
