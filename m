Received: from eggs.gnu.org ([2001:4830:134:3::10]:48353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvSY-0005Z5-Ho
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dDvSX-000634-FZ
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:17:58 -0400
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<3e999ccc-5a8b-9111-06eb-d10bb83f6c43@redhat.com>
	<20170525074012.GB8487@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a64982a5-3558-9048-e57a-2571652f6565@redhat.com>
Date: Thu, 25 May 2017 18:17:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170525074012.GB8487@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/18] Block layer thread safety, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com



On 25/05/2017 09:40, Fam Zheng wrote:
> On Wed, 05/24 10:32, Paolo Bonzini wrote:
>>
>> Ping?
>>
> 
> Looks good to me except for the mingw 32bit build failure reported by patchew:
> 
> http://patchew.org/QEMU/20170511144208.24075-1-pbonzini@redhat.com/
> 
> Do you want to fix it?

Yes, I misread the code.

Here is the fix:

diff --git a/include/qemu/stats64.h b/include/qemu/stats64.h
index f9baf9b..8cfad9d 100644
--- a/include/qemu/stats64.h
+++ b/include/qemu/stats64.h
@@ -37,7 +37,7 @@ static inline void stat64_init(Stat64 *s, uint64_t value)

 static inline uint64_t stat64_get(const Stat64 *s)
 {
-    return atomic_read(&s->value);
+    return atomic_read__nocheck(&s->value);
 }

 static inline void stat64_add(Stat64 *s, uint64_t value)
@@ -47,17 +47,17 @@ static inline void stat64_add(Stat64 *s, uint64_t value)

 static inline void stat64_min(Stat64 *s, uint64_t value)
 {
-    uint64_t orig = atomic_read(&s->value);
+    uint64_t orig = atomic_read__nocheck(&s->value);
     while (orig > value) {
-        orig = atomic_cmpxchg(&s->value, orig, value);
+        orig = atomic_cmpxchg__nocheck(&s->value, orig, value);
     }
 }

 static inline void stat64_max(Stat64 *s, uint64_t value)
 {
-    uint64_t orig = atomic_read(&s->value);
+    uint64_t orig = atomic_read__nocheck(&s->value);
     while (orig < value) {
-        orig = atomic_cmpxchg(&s->value, orig, value);
+        orig = atomic_cmpxchg__nocheck(&s->value, orig, value);
     }
 }
 #else


I'll fix this and the long length, and resubmit.

Paolo
