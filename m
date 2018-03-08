Received: from eggs.gnu.org ([2001:4830:134:3::10]:47741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etu5d-0002Ld-LN
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:52:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etu5Z-0002Ix-T8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:52:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etu5Z-0002Ib-OQ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:52:01 -0500
Date: Thu, 8 Mar 2018 19:51:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180308115149.GG32252@xz-mi>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-18-peterx@redhat.com>
	<20180308110413.044b15ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308110413.044b15ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 17/23] qapi: introduce new cmd option
 "allow-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 08, 2018 at 11:04:13AM +0100, Igor Mammedov wrote:

[...]

> > diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> > index 20578dcd48..b76798800c 100644
> > --- a/include/qapi/qmp/dispatch.h
> > +++ b/include/qapi/qmp/dispatch.h
> > @@ -23,6 +23,7 @@ typedef enum QmpCommandOptions
> >  {
> >      QCO_NO_OPTIONS = 0x0,
> >      QCO_NO_SUCCESS_RESP = 0x1,
> > +    QCO_ALLOW_OOB = 0x2,
> Options are essentially bitmask,
> so using shift for value would be more explicit way to express it.
> 
>   QCO_ALLOW_OOB = (1U << 1)

I'll squash the change into the patch:

diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h         
index b4cb25888f..26eb13ff41 100644                   
--- a/include/qapi/qmp/dispatch.h      
+++ b/include/qapi/qmp/dispatch.h      
@@ -20,9 +20,9 @@ typedef void (QmpCommandFunc)(QDict *, QObject **, Error **);
                                                                               
 typedef enum QmpCommandOptions        
 {                                                                             
-    QCO_NO_OPTIONS = 0x0,                                                     
-    QCO_NO_SUCCESS_RESP = 0x1,        
-    QCO_ALLOW_OOB = 0x2,                                                      
+    QCO_NO_OPTIONS            =  0x0,                                         
+    QCO_NO_SUCCESS_RESP       =  (1U << 0),                                   
+    QCO_ALLOW_OOB             =  (1U << 1),                                   
 } QmpCommandOptions;                                        
                                           
 typedef struct QmpCommand                                                     

Since the change is trivial, I'll keep r-bs for Stefan and Fam.
Anyone who thinks I shouldn't please shoot.  Thanks,

-- 
Peter Xu
