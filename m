Received: from eggs.gnu.org ([2001:4830:134:3::10]:33662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drGrO-0001nT-HZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1drGrL-0007BP-D7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1drGrL-0007AT-4K
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 01:02:11 -0400
Date: Mon, 11 Sep 2017 13:02:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170911050200.GB32341@lemon.lan>
References: <1504888905-22396-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1504888905-22396-3-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504888905-22396-3-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH v4 2/3] backup: Adds Backup Tool
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

On Fri, 09/08 22:11, Ishani Chugh wrote:
> +def build_parser():
> +    backup_tool = BackupTool()
> +    parser = ArgumentParser()
> +    subparsers = parser.add_subparsers(title='Subcommands',
> +                                       description='Valid Subcommands',
> +                                       help='Subcommand help')
> +    guest_parser = subparsers.add_parser('guest', help='Manage guest(s)')
> +    guest_subparsers = guest_parser.add_subparsers(title='Guest Subparser')
> +#   Guest list

Odd indentation of comments. Please align the # at 4th colume line other code
lines.  The same to below.

> +    guest_list_parser = guest_subparsers.add_parser('list',
> +                                                    help='Lists all guests')
> +    guest_list_parser.set_defaults(func=backup_tool.list)
> +
> +#   Guest add
> +    guest_add_parser = guest_subparsers.add_parser('add', help='Adds a guest')
> +    guest_add_required = guest_add_parser.add_argument_group('Required \
> +                                                                Arguments')
> +    guest_add_required.add_argument('--guest', action='store', type=str,
> +                                    help='Name of the guest', required=True)
> +    guest_add_required.add_argument('--qmp', action='store', type=str,
> +                                    help='Path of socket', required=True)
> +    guest_add_parser.set_defaults(func=backup_tool.guest_add_wrapper)
> +
> +#   Guest Remove
> +    guest_remove_parser = guest_subparsers.add_parser('remove',
> +                                                      help='Removes a guest')
> +    guest_remove_required = guest_remove_parser.add_argument_group('Required \
> +                                                                    Arguments')
> +    guest_remove_required.add_argument('--guest', action='store', type=str,
> +                                       help='Name of the guest', required=True)
> +    guest_remove_parser.set_defaults(func=backup_tool.guest_remove_wrapper)
> +
> +    drive_parser = subparsers.add_parser('drive',
> +                                         help='Adds drive(s) for backup')
> +    drive_subparsers = drive_parser.add_subparsers(title='Add subparser',
> +                                                   description='Drive \
> +                                                                subparser')
> +#   Drive Add
> +    drive_add_parser = drive_subparsers.add_parser('add',
> +                                                   help='Adds new \
> +                                                         drive for backup')
> +    drive_add_required = drive_add_parser.add_argument_group('Required \
> +                                                                Arguments')
> +    drive_add_required.add_argument('--guest', action='store', type=str,
> +                                    help='Name of the guest', required=True)
> +    drive_add_required.add_argument('--id', action='store',
> +                                    type=str, help='Drive ID', required=True)
> +    drive_add_parser.add_argument('--target', nargs='?',
> +                                  default=None, help='Destination path')
> +    drive_add_parser.set_defaults(func=backup_tool.drive_add_wrapper)
> +
> +    backup_parser = subparsers.add_parser('backup', help='Creates backup')
> +
> +#   Backup
> +    backup_parser_required = backup_parser.add_argument_group('Required \
> +                                                                Arguments')
> +    backup_parser_required.add_argument('--guest', action='store', type=str,
> +                                        help='Name of the guest',
> +                                        required=True)
> +    backup_parser.set_defaults(func=backup_tool.fullbackup_wrapper)
> +
> +#   Restore
> +    restore_parser = subparsers.add_parser('restore', help='Restores drives')
> +    restore_parser_required = restore_parser.add_argument_group('Required \
> +                                                                Arguments')
> +    restore_parser_required.add_argument('--guest', action='store',
> +                                         type=str, help='Name of the guest',
> +                                         required=True)
> +    restore_parser.set_defaults(func=backup_tool.restore_wrapper)
> +
> +    return parser
> +
> +
> +def main():
> +    parser = build_parser()
> +    args = parser.parse_args()
> +    args.func(args)
> +
> +if __name__ == '__main__':
> +    main()
> --
> 2.7.4
> 

Fam
