Received: from eggs.gnu.org ([2001:4830:134:3::10]:53449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjaF-0003Yx-NV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnjaB-0005UR-Oa
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnjaB-0005Ty-IX
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:21:35 -0400
References: <20170314100838.12647-1-roman.penyaev@profitbricks.com>
	<20170314100838.12647-2-roman.penyaev@profitbricks.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f191552b-88c8-e5d4-b7b7-953a201971b4@redhat.com>
Date: Tue, 14 Mar 2017 11:21:32 +0100
MIME-Version: 1.0
In-Reply-To: <20170314100838.12647-2-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] scripts/qemugdb/coroutine.py: get
 pthread pointer from '(gdb) thread info $id' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org



On 14/03/2017 11:08, Roman Pen wrote:
> For sure under corefile debugging it is not possible to invoke
> any syscalls, like arch_prctl(), so avoid doing that.  That will
> simplify the script.

Is the issue that start_thread only works in the main thread stack (i.e.
not on coroutines)?

> +    num = gdb.selected_thread().num
> +    thr = gdb.execute('info thread %d' % num, to_string=True)

What versions of gdb support gdb.execute?  Also, what happens if
localization is in effect?

Paolo

> +    thr = thr.split('\n')[1]
>      try:
> -        return f.read_var("arg")
> -    except ValueError:
> -        return get_fs_base()
> +        return re.search('Thread ([0-9a-zx]+)', thr).group(1)
> +    except:
> +        raise ValueError("Unable to find pthread address in 'info thread %d' output.\n"
> +                         "Probably version mismatch of libthread_db.so library?" %
> +                         num)
