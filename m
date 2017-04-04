Received: from eggs.gnu.org ([2001:4830:134:3::10]:42120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cvMVx-0001qD-8l
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cvMVr-0006dw-3R
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:20:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:49930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1cvMVq-0006da-BK
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:20:39 -0400
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-3-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CJbFP9wRjAxiJrq9uyHecWwqFvYDJc6_FPnd=PubZng9w@mail.gmail.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <5459b61a-96dd-a721-0e9f-ba3d3f8c040b@intel.com>
Date: Tue, 4 Apr 2017 14:21:38 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJbFP9wRjAxiJrq9uyHecWwqFvYDJc6_FPnd=PubZng9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/7] tpm-backend: Move thread handling
 inside TPMBackend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com



On 04.04.2017 13:56, Marc-André Lureau wrote:
> Hi
>
> On Fri, Mar 31, 2017 at 5:04 PM Amarnath Valluri 
> <amarnath.valluri@intel.com <mailto:amarnath.valluri@intel.com>> wrote:
>
>     Move thread handling inside TPMBackend, this way backend
>     implementations need
>     not to maintain their own thread life cycle, instead they needs to
>     implement
>     'handle_request()' class method that always been called from a thread.
>
>     This change also demands to move TPMBackendClass definition to
>     tpm_backend_int.h. As handle_request() method is internal to
>     TPMBackend and its
>     derived classes, and shall not be visible for others.
>
>
>  Alternatively, I think you could remove tpm_backend_int.h, it doesn't 
> bring much.
Yes, initially i even thought the same. _int.h makes sense, if we could 
move both TPMBackend, and TPMBackendClass _int.h, which shall be used by 
TPM backend implementations. And the actual backend API is exposed by 
tpm_backend.h, but the issue with QLIST member defined in TPMBackend 
which is been used by
QLIST_FOREACH_SAFE in tpm.c

>
>
>     Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com
>     <mailto:amarnath.valluri@intel.com>>
>     ---
>      backends/tpm.c                   | 66
>     ++++++++++++++++++++++++++--------------
>      hw/tpm/tpm_passthrough.c         | 57
>     +++++-----------------------------
>      include/sysemu/tpm_backend.h     | 19 +++---------
>      include/sysemu/tpm_backend_int.h | 19 ++++++------
>      4 files changed, 67 insertions(+), 94 deletions(-)
>
>     diff --git a/backends/tpm.c b/backends/tpm.c
>     index 536f262..50a7809 100644
>     --- a/backends/tpm.c
>     +++ b/backends/tpm.c
>     @@ -20,6 +20,25 @@
>      #include "qemu/thread.h"
>      #include "sysemu/tpm_backend_int.h"
>
>     +static void tpm_backend_worker_thread(gpointer data, gpointer
>     user_data)
>     +{
>     +    TPMBackend *s = TPM_BACKEND(user_data);
>     +    TPMBackendClass *k  = TPM_BACKEND_GET_CLASS(s);
>     +
>     +    if (k->handle_request) {
>     +        k->handle_request(s, (TPMBackendCmd)data);
>     +    }
>     +}
>
>
> Shouldn't handle_request be required by subclasses? I would have an 
> assert()
Yes, i agree, i will do the change
>
>     +
>     +static void tpm_backend_thread_end(TPMBackend *s)
>     +{
>     +    if (s->thread_pool) {
>     +        g_thread_pool_push(s->thread_pool,
>     (gpointer)TPM_BACKEND_CMD_END, NULL);
>     +        g_thread_pool_free(s->thread_pool, FALSE, TRUE);
>     +        s->thread_pool = NULL;
>     +    }
>     +}
>     +
>      enum TpmType tpm_backend_get_type(TPMBackend *s)
>      {
>          TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
>     @@ -39,6 +58,8 @@ void tpm_backend_destroy(TPMBackend *s)
>          TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
>
>          k->ops->destroy(s);
>     +
>     +    tpm_backend_thread_end(s);
>      }
>
>      int tpm_backend_init(TPMBackend *s, TPMState *state,
>     @@ -46,13 +67,26 @@ int tpm_backend_init(TPMBackend *s, TPMState
>     *state,
>      {
>          TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
>
>     -    return k->ops->init(s, state, datacb);
>     +    s->tpm_state = state;
>     +    s->recv_data_callback = datacb;
>     +
>     +    return k->ops->init(s);
>      }
>
>      int tpm_backend_startup_tpm(TPMBackend *s)
>      {
>          TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
>
>     +    /* terminate a running TPM */
>     +    tpm_backend_thread_end(s);
>     +
>     +    if (!s->thread_pool) {
>
>
> That check seems pointless to me, after thread_end() s->thread_pool is 
> always NULL
Ok, I will remove the check.
>
>     +        s->thread_pool =
>     g_thread_pool_new(tpm_backend_worker_thread, s, 1,
>     +                                           TRUE, NULL);
>     +        g_thread_pool_push(s->thread_pool,
>     (gpointer)TPM_BACKEND_CMD_INIT,
>     +                           NULL);
>     +    }
>     +
>          return k->ops->startup_tpm(s);
>      }
>
>     @@ -72,9 +106,8 @@ size_t tpm_backend_realloc_buffer(TPMBackend
>     *s, TPMSizedBuffer *sb)
>
>      void tpm_backend_deliver_request(TPMBackend *s)
>      {
>     -    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
>     -
>     -    k->ops->deliver_request(s);
>     +    g_thread_pool_push(s->thread_pool,
>     (gpointer)TPM_BACKEND_CMD_PROCESS_CMD,
>     +                       NULL);
>      }
>
>      void tpm_backend_reset(TPMBackend *s)
>     @@ -82,6 +115,8 @@ void tpm_backend_reset(TPMBackend *s)
>          TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
>
>          k->ops->reset(s);
>     +
>     +    tpm_backend_thread_end(s);
>      }
>
>      void tpm_backend_cancel_cmd(TPMBackend *s)
>     @@ -156,29 +191,15 @@ static void tpm_backend_instance_init(Object
>     *obj)
>                                   tpm_backend_prop_get_opened,
>                                   tpm_backend_prop_set_opened,
>                                   NULL);
>     -}
>
>     -void tpm_backend_thread_deliver_request(TPMBackendThread *tbt)
>     -{
>     -   g_thread_pool_push(tbt->pool,
>     (gpointer)TPM_BACKEND_CMD_PROCESS_CMD, NULL);
>      }
>
>     -void tpm_backend_thread_create(TPMBackendThread *tbt,
>     -                               GFunc func, gpointer user_data)
>     +static void tpm_backend_instance_finalize(Object *obj)
>      {
>     -    if (!tbt->pool) {
>     -        tbt->pool = g_thread_pool_new(func, user_data, 1, TRUE,
>     NULL);
>     -        g_thread_pool_push(tbt->pool,
>     (gpointer)TPM_BACKEND_CMD_INIT, NULL);
>     -    }
>     -}
>     +    TPMBackend *s = TPM_BACKEND(obj);
>
>     -void tpm_backend_thread_end(TPMBackendThread *tbt)
>     -{
>     -    if (tbt->pool) {
>     -        g_thread_pool_push(tbt->pool,
>     (gpointer)TPM_BACKEND_CMD_END, NULL);
>     -        g_thread_pool_free(tbt->pool, FALSE, TRUE);
>     -        tbt->pool = NULL;
>     -    }
>     +    g_free(s->id);
>     +    tpm_backend_thread_end(s);
>      }
>
>      static const TypeInfo tpm_backend_info = {
>     @@ -186,6 +207,7 @@ static const TypeInfo tpm_backend_info = {
>          .parent = TYPE_OBJECT,
>          .instance_size = sizeof(TPMBackend),
>          .instance_init = tpm_backend_instance_init,
>     +    .instance_finalize = tpm_backend_instance_finalize,
>          .class_size = sizeof(TPMBackendClass),
>          .abstract = true,
>      };
>     diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
>     index a0baf5f..606e064 100644
>     --- a/hw/tpm/tpm_passthrough.c
>     +++ b/hw/tpm/tpm_passthrough.c
>     @@ -47,20 +47,9 @@
>          OBJECT_CHECK(TPMPassthruState, (obj), TYPE_TPM_PASSTHROUGH)
>
>      /* data structures */
>     -typedef struct TPMPassthruThreadParams {
>     -    TPMState *tpm_state;
>     -
>     -    TPMRecvDataCB *recv_data_callback;
>     -    TPMBackend *tb;
>     -} TPMPassthruThreadParams;
>     -
>      struct TPMPassthruState {
>          TPMBackend parent;
>
>     -    TPMBackendThread tbt;
>     -
>     -    TPMPassthruThreadParams tpm_thread_params;
>     -
>          char *tpm_dev;
>          int tpm_fd;
>          bool tpm_executing;
>     @@ -214,12 +203,9 @@ static int
>     tpm_passthrough_unix_transfer(TPMPassthruState *tpm_pt,
>                                              selftest_done);
>      }
>
>     -static void tpm_passthrough_worker_thread(gpointer data,
>     -                                          gpointer user_data)
>     +static void tpm_passthrough_handle_request(TPMBackend *tb,
>     TPMBackendCmd cmd)
>      {
>     -    TPMPassthruThreadParams *thr_parms = user_data;
>     -    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(thr_parms->tb);
>     -    TPMBackendCmd cmd = (TPMBackendCmd)data;
>     +    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
>          bool selftest_done = false;
>
>          DPRINTF("tpm_passthrough: processing command type %d\n", cmd);
>     @@ -227,12 +213,12 @@ static void
>     tpm_passthrough_worker_thread(gpointer data,
>          switch (cmd) {
>          case TPM_BACKEND_CMD_PROCESS_CMD:
>              tpm_passthrough_unix_transfer(tpm_pt,
>     - thr_parms->tpm_state->locty_data,
>     + tb->tpm_state->locty_data,
>      &selftest_done);
>
>     - thr_parms->recv_data_callback(thr_parms->tpm_state,
>     - thr_parms->tpm_state->locty_number,
>     -                                      selftest_done);
>     +        tb->recv_data_callback(tb->tpm_state,
>     +  tb->tpm_state->locty_number,
>     +                               selftest_done);
>              break;
>          case TPM_BACKEND_CMD_INIT:
>          case TPM_BACKEND_CMD_END:
>     @@ -248,15 +234,6 @@ static void
>     tpm_passthrough_worker_thread(gpointer data,
>       */
>      static int tpm_passthrough_startup_tpm(TPMBackend *tb)
>      {
>     -    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
>     -
>     -    /* terminate a running TPM */
>     -    tpm_backend_thread_end(&tpm_pt->tbt);
>     -
>     -    tpm_backend_thread_create(&tpm_pt->tbt,
>     - tpm_passthrough_worker_thread,
>     - &tpm_pt->tpm_thread_params);
>     -
>          return 0;
>      }
>
>
> I would remove startup_tpm callback (could be a seperate patch)
Do you mean, remove the method from TPMDriverOps interface itself, of 
just the empty method here. The empty method is removed in 4/7 where we 
made them optional methods.
>
>     @@ -268,20 +245,11 @@ static void tpm_passthrough_reset(TPMBackend
>     *tb)
>
>          tpm_passthrough_cancel_cmd(tb);
>
>     -    tpm_backend_thread_end(&tpm_pt->tbt);
>     -
>          tpm_pt->had_startup_error = false;
>      }
>
>     -static int tpm_passthrough_init(TPMBackend *tb, TPMState *s,
>     -                                TPMRecvDataCB *recv_data_cb)
>     +static int tpm_passthrough_init(TPMBackend *tb)
>      {
>     -    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
>     -
>     -    tpm_pt->tpm_thread_params.tpm_state = s;
>     -    tpm_pt->tpm_thread_params.recv_data_callback = recv_data_cb;
>     -    tpm_pt->tpm_thread_params.tb = tb;
>     -
>          return 0;
>      }
>
>     @@ -315,13 +283,6 @@ static size_t
>     tpm_passthrough_realloc_buffer(TPMSizedBuffer *sb)
>          return sb->size;
>      }
>
>     -static void tpm_passthrough_deliver_request(TPMBackend *tb)
>     -{
>     -    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
>     -
>     - tpm_backend_thread_deliver_request(&tpm_pt->tbt);
>     -}
>     -
>      static void tpm_passthrough_cancel_cmd(TPMBackend *tb)
>      {
>          TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
>     @@ -483,8 +444,6 @@ static void tpm_passthrough_destroy(TPMBackend
>     *tb)
>
>          tpm_passthrough_cancel_cmd(tb);
>
>     -    tpm_backend_thread_end(&tpm_pt->tbt);
>     -
>          qemu_close(tpm_pt->tpm_fd);
>          qemu_close(tpm_pt->cancel_fd);
>
>     @@ -520,7 +479,6 @@ static const TPMDriverOps
>     tpm_passthrough_driver = {
>          .realloc_buffer           = tpm_passthrough_realloc_buffer,
>          .reset                    = tpm_passthrough_reset,
>          .had_startup_error        = tpm_passthrough_get_startup_error,
>     -    .deliver_request          = tpm_passthrough_deliver_request,
>          .cancel_cmd               = tpm_passthrough_cancel_cmd,
>          .get_tpm_established_flag =
>     tpm_passthrough_get_tpm_established_flag,
>          .reset_tpm_established_flag =
>     tpm_passthrough_reset_tpm_established_flag,
>     @@ -540,6 +498,7 @@ static void
>     tpm_passthrough_class_init(ObjectClass *klass, void *data)
>          TPMBackendClass *tbc = TPM_BACKEND_CLASS(klass);
>
>          tbc->ops = &tpm_passthrough_driver;
>     +    tbc->handle_request = tpm_passthrough_handle_request;
>      }
>
>      static const TypeInfo tpm_passthrough_info = {
>     diff --git a/include/sysemu/tpm_backend.h
>     b/include/sysemu/tpm_backend.h
>     index e7f590d..98b6112 100644
>     --- a/include/sysemu/tpm_backend.h
>     +++ b/include/sysemu/tpm_backend.h
>     @@ -29,22 +29,17 @@
>
>      typedef struct TPMBackendClass TPMBackendClass;
>      typedef struct TPMBackend TPMBackend;
>     -
>      typedef struct TPMDriverOps TPMDriverOps;
>     -
>     -struct TPMBackendClass {
>     -    ObjectClass parent_class;
>     -
>     -    const TPMDriverOps *ops;
>     -
>     -    void (*opened)(TPMBackend *s, Error **errp);
>     -};
>     +typedef void (TPMRecvDataCB)(TPMState *, uint8_t locty, bool
>     selftest_done);
>
>      struct TPMBackend {
>          Object parent;
>
>          /*< protected >*/
>          bool opened;
>     +    TPMState *tpm_state;
>     +    GThreadPool *thread_pool;
>     +    TPMRecvDataCB *recv_data_callback;
>
>          char *id;
>          enum TpmModel fe_model;
>     @@ -54,8 +49,6 @@ struct TPMBackend {
>          QLIST_ENTRY(TPMBackend) list;
>      };
>
>     -typedef void (TPMRecvDataCB)(TPMState *, uint8_t locty, bool
>     selftest_done);
>     -
>      typedef struct TPMSizedBuffer {
>          uint32_t size;
>          uint8_t  *buffer;
>     @@ -71,7 +64,7 @@ struct TPMDriverOps {
>          void (*destroy)(TPMBackend *t);
>
>          /* initialize the backend */
>     -    int (*init)(TPMBackend *t, TPMState *s, TPMRecvDataCB *datacb);
>     +    int (*init)(TPMBackend *t);
>          /* start up the TPM on the backend */
>          int (*startup_tpm)(TPMBackend *t);
>          /* returns true if nothing will ever answer TPM requests */
>     @@ -79,8 +72,6 @@ struct TPMDriverOps {
>
>          size_t (*realloc_buffer)(TPMSizedBuffer *sb);
>
>     -    void (*deliver_request)(TPMBackend *t);
>     -
>          void (*reset)(TPMBackend *t);
>
>          void (*cancel_cmd)(TPMBackend *t);
>     diff --git a/include/sysemu/tpm_backend_int.h
>     b/include/sysemu/tpm_backend_int.h
>     index 00639dd..9b48a35 100644
>     --- a/include/sysemu/tpm_backend_int.h
>     +++ b/include/sysemu/tpm_backend_int.h
>     @@ -22,15 +22,6 @@
>      #ifndef TPM_BACKEND_INT_H
>      #define TPM_BACKEND_INT_H
>
>     -typedef struct TPMBackendThread {
>     -    GThreadPool *pool;
>     -} TPMBackendThread;
>     -
>     -void tpm_backend_thread_deliver_request(TPMBackendThread *tbt);
>     -void tpm_backend_thread_create(TPMBackendThread *tbt,
>     -                               GFunc func, gpointer user_data);
>     -void tpm_backend_thread_end(TPMBackendThread *tbt);
>     -
>      typedef enum TPMBackendCmd {
>          TPM_BACKEND_CMD_INIT = 1,
>          TPM_BACKEND_CMD_PROCESS_CMD,
>     @@ -38,4 +29,14 @@ typedef enum TPMBackendCmd {
>          TPM_BACKEND_CMD_TPM_RESET,
>      } TPMBackendCmd;
>
>     +struct TPMBackendClass {
>     +    ObjectClass parent_class;
>     +
>     +    const TPMDriverOps *ops;
>     +
>     +    void (*opened)(TPMBackend *s, Error **errp);
>     +
>     +    void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
>     +};
>     +
>      #endif /* TPM_BACKEND_INT_H */
>     --
>     2.7.4
>
>
> looks good otherwise
> -- 
> Marc-André Lureau
