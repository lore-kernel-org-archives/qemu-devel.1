Received: from eggs.gnu.org ([2001:4830:134:3::10]:56127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emmuJ-0005Sj-A1
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emmuI-0007T1-FP
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 15:46:59 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-9-git-send-email-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0739c439-4c1e-4c55-0c68-2c64978079eb@redhat.com>
Date: Fri, 16 Feb 2018 14:46:35 -0600
MIME-Version: 1.0
In-Reply-To: <1518702707-7077-9-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] iotests: add file_path helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, Jeff Cody <jcody@redhat.com>

On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> Simple way to have auto generated filenames with auto clenup. Like

s/clenup/cleanup/

> FilePath but without using 'with' statement and without additional
> indentation of the whole test.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   tests/qemu-iotests/iotests.py | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)

Jeff, where do we stand on your iotests cleanups?  Is this something you 
want to use?

> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index c1302a2f9b..f2d05ca3fd 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -27,6 +27,7 @@ import struct
>   import json
>   import signal
>   import logging
> +import atexit
>   
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'scripts'))
>   import qtest
> @@ -250,6 +251,37 @@ class FilePath(object):
>           return False
>   
>   
> +def file_path_remover():
> +    for path in reversed(file_path_remover.paths):
> +        try:
> +            os.remove(path)
> +        except OSError:
> +            pass
> +
> +
> +def file_path(*names):
> +    ''' Another way to get auto-generated filename that cleans itself up.
> +
> +    Use it as simple as:
> +
> +    img_a, img_b = file_path('a.img', 'b.img')
> +    sock = file_path('socket')
> +    '''
> +
> +    if not hasattr(file_path_remover, 'paths'):
> +        file_path_remover.paths = []
> +        atexit.register(file_path_remover)
> +
> +    paths = []
> +    for name in names:
> +        filename = '{0}-{1}'.format(os.getpid(), name)
> +        path = os.path.join(test_dir, filename)
> +        file_path_remover.paths.append(path)
> +        paths.append(path)
> +
> +    return paths[0] if len(paths) == 1 else paths
> +
> +
>   class VM(qtest.QEMUQtestMachine):
>       '''A QEMU VM'''
>   
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
