Received: from eggs.gnu.org ([2001:4830:134:3::10]:39676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPlUW-0006t5-Ep
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dPlUV-0008C3-M4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 04:04:56 -0400
Date: Tue, 27 Jun 2017 16:04:43 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170627080443.GC14166@lemon.lan>
References: <1496649172-26982-1-git-send-email-ashijeetacharya@gmail.com>
	<1496649172-26982-8-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496649172-26982-8-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 7/8] vmdk: Update metadata for multiple
 clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 06/05 13:22, Ashijeet Acharya wrote:
> @@ -1876,6 +1942,13 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>          offset += n_bytes;
>          bytes_done += n_bytes;
>  
> +        while (m_data->next != NULL) {

If you do

           while (m_data) {

> +            VmdkMetaData *next;
> +            next = m_data->next;
> +            g_free(m_data);
> +            m_data = next;
> +        }
> +
>          /* update CID on the first write every time the virtual disk is
>           * opened */
>          if (!s->cid_updated) {
> @@ -1886,6 +1959,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>              s->cid_updated = true;
>          }
>      }
> +    g_free(m_data);

then you can remove this line.

>      return 0;
>  }
>  
> -- 
> 2.6.2
> 
