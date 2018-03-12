Received: from eggs.gnu.org ([2001:4830:134:3::10]:45137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evN69-0007q8-Og
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evN63-00050x-JQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:02:41 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evN63-0004z4-BU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:02:35 -0400
Received: by mail-wm0-x244.google.com with SMTP id i3so15906292wmi.4
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:02:35 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
	<20180227095248.1060.40374.stgit@pasha-VirtualBox>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53570b7e-8975-ce4e-acc1-fb5a752dc203@redhat.com>
Date: Mon, 12 Mar 2018 14:02:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180227095248.1060.40374.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 13/22] replay: push replay_mutex_lock up
 the call tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, alex.bennee@linaro.org

On 27/02/2018 10:52, Pavel Dovgalyuk wrote:
>  
> +void replay_init_locks(void)
> +{
> +    replay_mutex_init();
> +}
> +

This should not be needed as a public function: until replay_mode
is set, replay_lock and replay_unlock do nothing.  I'm squashing this:

diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index eeec66b8f4..3ced6bc231 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -63,8 +63,6 @@ void replay_mutex_unlock(void);
 
 /* Replay process control functions */
 
-/*! Enables and take replay locks (even if we don't use it) */
-void replay_init_locks(void);
 /*! Enables recording or saving event log with specified parameters */
 void replay_configure(struct QemuOpts *opts);
 /*! Initializes timers used for snapshotting and enables events recording */
diff --git a/replay/replay.c b/replay/replay.c
index a8b57cd077..b3e814a875 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -207,11 +207,6 @@ out:
     return res;
 }
 
-void replay_init_locks(void)
-{
-    replay_mutex_init();
-}
-
 static void replay_enable(const char *fname, int mode)
 {
     const char *fmode = NULL;
@@ -238,8 +233,9 @@ static void replay_enable(const char *fname, int mode)
     }
 
     replay_filename = g_strdup(fname);
-
     replay_mode = mode;
+    replay_mutex_init();
+
     replay_state.data_kind = -1;
     replay_state.instructions_count = 0;
     replay_state.current_step = 0;
diff --git a/vl.c b/vl.c
index 08e81c46a0..5925a4b502 100644
--- a/vl.c
+++ b/vl.c
@@ -3059,7 +3059,6 @@ int main(int argc, char **argv, char **envp)
     qemu_init_cpu_list();
     qemu_init_cpu_loop();
 
-    replay_init_locks();
     qemu_mutex_lock_iothread();
 
     atexit(qemu_run_exit_notifiers);
