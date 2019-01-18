Received: from eggs.gnu.org ([209.51.188.92]:45918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gkR8A-0003ih-J9
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gkR89-0001Cy-CN
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:12:06 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44748
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gkR88-00016d-7n
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:12:05 -0500
References: <1547805767-24863-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <4a41e8be-eb7d-df71-e5fa-2fef12a2dd9b@cn.fujitsu.com>
Date: Fri, 18 Jan 2019 18:11:55 +0800
MIME-Version: 1.0
In-Reply-To: <1547805767-24863-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] Acceptance tests: use linux-3.6 and
 set vm memory to 4GiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

Sorry, there are some typos, please ignore this version
i will correct in V2


On 1/18/19 18:02, Li Zhijian wrote:
> linux-3.6 kernel shipped by Fedora-19 cannot support xldflags so that it

s/Fedora-19/Fedora-18


> cannot support loading more than 2GiB initrd
>
> CC: Wainer dos Santos Moschetta <wainersm@redhat.com>
> CC: Caio Carrara <ccarrara@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> ---
> this patch is basing on early Acceptance tests:
> https://patchwork.kernel.org/patch/10676415/
> ---
>   tests/acceptance/linux_initrd.py | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_initrd.py
> index 737355c..aeb9fde 100644
> --- a/tests/acceptance/linux_initrd.py
> +++ b/tests/acceptance/linux_initrd.py
> @@ -24,14 +24,16 @@ class LinuxInitrd(Test):
>   
>       timeout = 60
>   
> -    def test_with_2gib_file_should_exit_error_msg(self):
> +    def test_with_2gib_file_should_exit_error_msg_with_linux_v3_6(self):
>           """
>           Pretends to boot QEMU with an initrd file with size of 2GiB
>           and expect it exits with error message.
> +        Fedora-19 shipped with linux-3.6 which have not supported xloadflags

Ditto

Thanks

  

> +        cannot support more than 2GiB initrd.
>           """
> -        kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
> -                      'Everything/x86_64/os/images/pxeboot/vmlinuz')
> -        kernel_hash = '238e083e114c48200f80d889f7e32eeb2793e02a'
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora/li'
> +                      'nux/releases/18/Fedora/x86_64/os/images/pxeboot/vmlinuz')
> +        kernel_hash = '41464f68efe42b9991250bed86c7081d2ccdbb21'
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>           max_size = 2 * (1024 ** 3) - 1
>   
> @@ -39,8 +41,8 @@ class LinuxInitrd(Test):
>               initrd.seek(max_size)
>               initrd.write(b'\0')
>               initrd.flush()
> -            cmd = "%s -kernel %s -initrd %s" % (self.qemu_bin, kernel_path,
> -                                                initrd.name)
> +            cmd = "%s -kernel %s -initrd %s -m 4096" % (
> +                  self.qemu_bin, kernel_path, initrd.name)
>               res = run(cmd, ignore_status=True)
>               self.assertEqual(res.exit_status, 1)
>               expected_msg = r'.*initrd is too large.*max: \d+, need %s.*' % (
