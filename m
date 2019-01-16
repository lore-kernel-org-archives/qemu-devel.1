Received: from eggs.gnu.org ([209.51.188.92]:50436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjmUs-0003Wa-QK
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjmUo-0001Dj-Sd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:48:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjmUh-00017F-NQ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:48:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so2278656wmj.1
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:48:37 -0800 (PST)
References: <20190114141006.1841-1-yuval.shaia@oracle.com>
	<ad603032-6658-a1db-06fc-80ffa4dbd682@redhat.com>
	<20190116100357.GA7260@lap1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1bd8cdbc-290e-5b15-37e9-f9984125a315@redhat.com>
Date: Wed, 16 Jan 2019 15:48:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190116100357.GA7260@lap1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: Verify that ptr is not NULL
 before freeing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org

On 1/16/19 11:03 AM, Yuval Shaia wrote:
> On Mon, Jan 14, 2019 at 04:11:22PM +0100, Philippe Mathieu-Daudé wrote:
>> Hi Yuval,
>>
>> On 1/14/19 3:10 PM, Yuval Shaia wrote:
>>> Make sure objects are not NULL before calling to non-nulll-safe
>>
>> null
> 
> will fix
> 
>>
>>> destructors.
>>>
>>> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>>> ---
>>>  hw/rdma/rdma_backend.c | 6 ++++--
>>>  hw/rdma/rdma_rm.c      | 7 ++++++-
>>>  2 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>>> index b49edaacaf..3ee5172c96 100644
>>> --- a/hw/rdma/rdma_backend.c
>>> +++ b/hw/rdma/rdma_backend.c
>>> @@ -1066,8 +1066,10 @@ static void mad_fini(RdmaBackendDev *backend_dev)
>>>      pr_dbg("Stopping MAD\n");
>>>      disable_rdmacm_mux_async(backend_dev);
>>>      qemu_chr_fe_disconnect(backend_dev->rdmacm_mux.chr_be);
>>> -    qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
>>> -    qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
>>> +    if (backend_dev->recv_mads_list.list) {
>>
>> This is only reachable when the backend didn't success at initializing,
>> right?
> 
> Yes, just to cover the case where fini() was called even when init() fails.

OK. Can you add a line about this in the commit description please?

With the comment updated:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
>>
>>> +        qlist_destroy_obj(QOBJECT(backend_dev->recv_mads_list.list));
>>> +        qemu_mutex_destroy(&backend_dev->recv_mads_list.lock);
>>> +    }
>>>  }
>>>  
>>>  int rdma_backend_get_gid_index(RdmaBackendDev *backend_dev,
>>> diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
>>> index f5b1295890..8bf241e91f 100644
>>> --- a/hw/rdma/rdma_rm.c
>>> +++ b/hw/rdma/rdma_rm.c
>>> @@ -41,6 +41,9 @@ static inline void res_tbl_init(const char *name, RdmaRmResTbl *tbl,
>>>  
>>>  static inline void res_tbl_free(RdmaRmResTbl *tbl)
>>>  {
>>> +    if (!tbl->bitmap) {
>>> +        return;
>>> +    }
>>>      qemu_mutex_destroy(&tbl->lock);
>>>      g_free(tbl->tbl);
>>>      g_free(tbl->bitmap);
>>> @@ -655,5 +658,7 @@ void rdma_rm_fini(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
>>>      res_tbl_free(&dev_res->cq_tbl);
>>>      res_tbl_free(&dev_res->pd_tbl);
>>>  
>>> -    g_hash_table_destroy(dev_res->qp_hash);
>>> +    if (dev_res->qp_hash) {
>>> +        g_hash_table_destroy(dev_res->qp_hash);
>>> +    }
>>>  }
>>>
