Received: from eggs.gnu.org ([209.51.188.92]:55207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goazE-00034Z-M9
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goazC-0003hG-6Q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:32:03 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-5-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <9cdec140-f130-6e4c-738b-0b2dd69ca714@redhat.com>
Date: Tue, 29 Jan 2019 16:31:55 -0500
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] iotests: Fix 207 to use QMP filters
 for qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org



On 1/23/19 9:46 AM, Max Reitz wrote:
> Fixes: 08fcd6111e1949f456e1b232ebeeb0cc17019a92
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Commit message is a bit barren, feel free to blame me for not realizing
that non-qcow2 tests used the feature I was rewriting. I may have chosen
to rewrite it differently if I had seen all the other callers. :\

Any opinions on how it shook out, now that you've had to fix things in
its wake? It felt like a lot of work to do not much to be honest, but
also it seemed like we were being too cavalier about the differences
between rich/qmp filters and text ones.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qemu-iotests/207     | 10 +++++++---
>  tests/qemu-iotests/207.out |  4 ++--
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
> index c617ee7453..dfd3c51bd1 100755
> --- a/tests/qemu-iotests/207
> +++ b/tests/qemu-iotests/207
> @@ -27,12 +27,16 @@ import re
>  iotests.verify_image_format(supported_fmts=['raw'])
>  iotests.verify_protocol(supported=['ssh'])
>  
> -def filter_hash(msg):
> -    return re.sub('"hash": "[0-9a-f]+"', '"hash": HASH', msg)
> +def filter_hash(qmsg):
> +    def _filter(key, value):
> +        if key == 'hash' and re.match('[0-9a-f]+', value):
> +            return 'HASH'
> +        return value
> +    return iotests.filter_qmp(qmsg, _filter)
>  
>  def blockdev_create(vm, options):
>      result = vm.qmp_log('blockdev-create', job_id='job0', options=options,
> -                        filters=[iotests.filter_testfiles, filter_hash])
> +                        filters=[iotests.filter_qmp_testfiles, filter_hash])
>  
>      if 'return' in result:
>          assert result['return'] == {}
> diff --git a/tests/qemu-iotests/207.out b/tests/qemu-iotests/207.out
> index 45ac7c2a8f..88d2240f54 100644
> --- a/tests/qemu-iotests/207.out
> +++ b/tests/qemu-iotests/207.out
> @@ -40,7 +40,7 @@ Job failed: remote host key does not match host_key_check 'wrong'
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "ssh", "location": {"host-key-check": {"hash": HASH, "mode": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}}, "size": 8388608}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode": "hash", "type": "md5"}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}}, "size": 8388608}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
> @@ -55,7 +55,7 @@ Job failed: remote host key does not match host_key_check 'wrong'
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
>  
> -{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "ssh", "location": {"host-key-check": {"hash": HASH, "mode": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
> +{"execute": "blockdev-create", "arguments": {"job_id": "job0", "options": {"driver": "ssh", "location": {"host-key-check": {"hash": "HASH", "mode": "hash", "type": "sha1"}, "path": "TEST_DIR/PID-t.img", "server": {"host": "127.0.0.1", "port": "22"}}, "size": 4194304}}}
>  {"return": {}}
>  {"execute": "job-dismiss", "arguments": {"id": "job0"}}
>  {"return": {}}
> 
