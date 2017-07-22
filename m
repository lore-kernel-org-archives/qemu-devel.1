Received: from eggs.gnu.org ([2001:4830:134:3::10]:42508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYj7y-00056T-0N
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:22:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYj7u-0000Z8-L5
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:22:42 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dYj7u-0000Yd-Fd
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 21:22:38 -0400
Received: by mail-qt0-x244.google.com with SMTP id l55so7713127qtl.3
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 18:22:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-3-ldoktor@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <17921ed7-dcf0-1e90-38dd-9bb77ba0166e@amsat.org>
Date: Fri, 21 Jul 2017 22:22:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170720162815.19802-3-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/11] qemu.py: Avoid dangerous arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, ehabkost@redhat.com

On 07/20/2017 01:28 PM, Lukáš Doktor wrote:
> The list object is mutable in python and potentially might modify other
> object's arguments when used as default argument. Reproducer:
> 
>      >>> vm1 = QEMUMachine("qemu")
>      >>> vm2 = QEMUMachine("qemu")
>      >>> vm1._wrapper.append("foo")
>      >>> print vm2._wrapper
>      ['foo']
> 
> In this case the `args` is actually copied so it would be safe to keep
> it, but it's not a good practice to keep it.
> 
> Signed-off-by: Lukáš Doktor <ldoktor@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   scripts/qemu.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 191c916..66fd863 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -23,7 +23,7 @@ import qmp.qmp
>   class QEMUMachine(object):
>       '''A QEMU VM'''
>   
> -    def __init__(self, binary, args=[], wrapper=[], name=None,
> +    def __init__(self, binary, args=None, wrapper=None, name=None,
>                    test_dir="/var/tmp", monitor_address=None,
>                    socket_scm_helper=None, debug=False):
>           '''
> @@ -39,6 +39,10 @@ class QEMUMachine(object):
>           @param debug: enable debug mode (forwarded to QMP helper and such)
>           @note: Qemu process is not started until launch() is used.
>           '''
> +        if args is None:
> +            args = []
> +        if wrapper is None:
> +            wrapper = []
>           if name is None:
>               name = "qemu-%d" % os.getpid()
>           if monitor_address is None:
> 
