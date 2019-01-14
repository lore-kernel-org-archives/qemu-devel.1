Received: from eggs.gnu.org ([209.51.188.92]:32881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj02t-00067o-Oj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj02s-00063B-Uh
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj02s-00061Q-N8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:04:42 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so22339047wrp.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 03:04:42 -0800 (PST)
References: <20190111201330.14473-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05f29d1e-11f0-62e0-af82-02a989e1c7b7@redhat.com>
Date: Mon, 14 Jan 2019 12:04:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190111201330.14473-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Fix error message when qemu dies
 from signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Hi Eric,

On 1/11/19 9:13 PM, Eric Blake wrote:
> When qemu dies from a signal, the python code gets a negative
> value for exitcode; but signal numbers are positive.  Copy the
> pattern used in qemu-iotests/iotests.py for reporting a positive
> value.
> 
> CC: qemu-trivial@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  scripts/qemu.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 6e3b0e67719..0a5e02eb56e 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -351,7 +351,7 @@ class QEMUMachine(object):
>                  command = ' '.join(self._qemu_full_args)
>              else:
>                  command = ''
> -            LOG.warn(msg, exitcode, command)
> +            LOG.warn(msg, -exitcode, command)

What about displaying signal name directly?

import signal

...

            msg = 'qemu received %s: %s'
            ...

            LOG.warn(msg, signal.Signals(-exitcode).name, command)

> 
>          self._launched = False
> 
