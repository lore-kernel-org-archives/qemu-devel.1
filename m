Received: from eggs.gnu.org ([2001:4830:134:3::10]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlFWz-0004mf-BL
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dlFWu-0004GE-AQ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:24:17 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dlFWu-0004Fv-3x
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:24:12 -0400
Received: by mail-wm0-x229.google.com with SMTP id b189so4096920wmd.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 07:24:12 -0700 (PDT)
Date: Fri, 25 Aug 2017 15:24:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170825142408.GB11641@stefanha-x1.localdomain>
References: <1503493480-21691-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1503493480-21691-3-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503493480-21691-3-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 2/3] Test for full Backup
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

On Wed, Aug 23, 2017 at 06:34:39PM +0530, Ishani Chugh wrote:
> +CONFIG_FILE=$TEST_DIR/backup-config
> +SOCKET=unix:$TEST_DIR/backup_socket
> +size=128M
> +
> +_make_test_img $size
> +export QEMU_BACKUP_CONFIG=$CONFIG_FILE
> +qemu_comm_method="monitor"
> +echo
> +_launch_qemu -drive if=virtio,file=$TEST_IMG -qmp $SOCKET,server,nowait

I tend to put doublequotes around any variable expansion unless the
variable is trivially guaranteed to contain no spaces.  Imagine
TEST_DIR="a b", then your command expands to:

  '-qmp' 'unix:a' 'b/backup_socket,server,nowait'

QEMU will think the option is -qmp unix:a only.

If you use doublequotes then the space will not split the argument into
multiple arguments:

  -qmp "$SOCKET",server,nowait

expands to:

  '-qmp' 'unix:a b/backup_socket,server,nowait'

Please use doublequotes around all variable expansion.

> +$PYTHON ../../contrib/backup/qemu-backup.py guest add --guest adad --qmp $SOCKET
> +$PYTHON ../../contrib/backup/qemu-backup.py drive add --id virtio0 --guest adad --target $TEST_DIR/virtio0
> +echo
> +echo "== Creating backup =="
> +$PYTHON ../../contrib/backup/qemu-backup.py backup --guest adad
> +_send_qemu_cmd $QEMU_HANDLE 'quit' ''
> +wait=1 _cleanup_qemu
> +echo
> +echo "== Comparing images =="
> +$QEMU_IMG compare $TEST_DIR/virtio0 $TEST_IMG
> +rm $TEST_DIR/virtio0
> +
> +_launch_qemu -drive if=virtio,id=virtio0,file=$TEST_IMG -qmp $SOCKET,server,nowait
> +echo
> +echo "== Writing Pattern =="
> +_send_qemu_cmd $QEMU_HANDLE 'qemu-io virtio0 "write -P 0x22 0 1M"' "(qemu)" | _filter_qemu_io
> +echo
> +echo "== Creating backup =="
> +$PYTHON ../../contrib/backup/qemu-backup.py backup --guest adad
> +_send_qemu_cmd $QEMU_HANDLE 'quit' ''
> +wait=1 _cleanup_qemu
> +echo
> +echo "== Comparing images =="
> +$QEMU_IMG compare $TEST_DIR/virtio0 $TEST_IMG
> +rm $TEST_DIR/virtio0
> +rm $CONFIG_FILE

All cleanup should be done from a trap handler function.  This way the
cleanup happens even if the process terminates early:

_cleanup()
{
	rm -f "$TEST_DIR"/virtio0
	rm -f "$CONFIG_FILE"
	_cleanup_test_img
}
trap "_cleanup; exit \$status" 0 1 2 3 15
