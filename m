Received: from eggs.gnu.org ([2001:4830:134:3::10]:48930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa0U9-0004Pj-Hn
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa0U4-0008AX-Jw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:25 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa0U4-00089l-FW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:20 -0400
Received: by mail-qt0-x244.google.com with SMTP id z6-v6so14074832qti.2
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180628153535.1411-1-f4bug@amsat.org>
	<20180628153535.1411-2-f4bug@amsat.org>
	<20180702071205.GI26002@lemon.usersys.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <beca5523-ea92-6c2b-c931-6b3523f18460@amsat.org>
Date: Mon, 2 Jul 2018 12:11:14 -0300
MIME-Version: 1.0
In-Reply-To: <20180702071205.GI26002@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] tests/vm: Support proxy / corporate
 firewall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

Hi Fam,

On 07/02/2018 04:12 AM, Fam Zheng wrote:
> On Thu, 06/28 12:35, Philippe Mathieu-Daudé wrote:
>> If ftp_proxy/http_proxy/https_proxy standard environment variables
>> are available, pass them to the vm images.
>>
>> As per 06cc3551714:
>> This is required when building behind corporate proxy/firewall, but
>> also help when using local cache server (ie: apt/yum).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/vm/ubuntu.i386 | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
>> index fc319e0e6e..be16ceed50 100755
>> --- a/tests/vm/ubuntu.i386
>> +++ b/tests/vm/ubuntu.i386
>> @@ -68,6 +68,10 @@ class UbuntuX86VM(basevm.BaseVM):
>>          self.boot(img_tmp, extra_args = ["-cdrom", self._gen_cloud_init_iso()])
>>          self.wait_ssh()
>>          self.ssh_root_check("touch /etc/cloud/cloud-init.disabled")
>> +        for k, v in os.environ.iteritems():
>> +            kl = k.lower()
>> +            if kl in ['ftp_proxy', 'http_proxy', 'https_proxy']:
>> +                self.ssh_root_check("echo 'Acquire::{}::Proxy \"{}\";' >> /etc/apt/apt.conf.d/01proxy".format(kl[:-6].upper(), v))
> 
> Reasonable, but do we want it for other apps and images? How about setting these
> env vars to ssh commands?

I see 2 different network usages:

1/ how the guest connect to the outer world, this goes via the firewall.
Here the change only affects apt* based commands (via the apt.conf file).
Do we have other commands requiring network connectivity? If we have,
then yes, we should add the same env vars in the guest.
One case I think of is "git submodule init" calling "git clone".

2/ how the host connect to the guest (ex: SSH).
In this case we use the loopback interface, thus no need to change.

>>          self.ssh_root_check("apt-get update")
>>          self.ssh_root_check("apt-get install -y cloud-initramfs-growroot")
>>          # Don't check the status in case the guest hang up too quickly
>> -- 
>> 2.18.0
>>
