Received: from eggs.gnu.org ([209.51.188.92]:40059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hBldU-0007Sg-Db
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hBldT-0002bY-GZ
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:33:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hBldT-0002Zn-4P
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 15:33:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h4so356319wre.7
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 12:33:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <87h8c82woh.fsf@dusky.pond.sub.org>
	<875zs3dkq6.fsf@dusky.pond.sub.org> <87v9zv1ncc.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fdaa779c-ed79-647b-6038-3df2353fe502@redhat.com>
Date: Wed, 3 Apr 2019 21:33:19 +0200
MIME-Version: 1.0
In-Reply-To: <87v9zv1ncc.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Issues around TYPE_INTERFACE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 03/04/19 10:53, Markus Armbruster wrote:
> Why (1) our interfaces can't have state:
> 
> Since interfaces are abstract, there's no such thing as an interface
> instance.

Well, there is.  Since all class instances are Objects, and interfaces
are applied to classes, interface instances must be Object.  In fact,
INTERFACE_CHECK() expects that to be the case, since it needs to go
spelunking into the class.  However, it is an implementation detail as
far as the interface _user_ is concerned.

> When @obj points to an instance of MyFrob, then we can safely cast it to
> any supertype of MyFrob.
> 
> MyIface is not a supertype of MyFrob, it's an interface.  WTF?
> 
> Turns out we only ever define MyIface in one of two ways:
> 
>     typedef struct MyIface MyIface;     // incomplete
> 
>     typedef struct MyIface {            // fake subtype of Object
>         Object parent;
>     } MyIface;
> 
> If we somehow know that only subtypes of SuperFrob have interface
> MyIface, then we can exploit that and safely cast to SuperFrob * or any
> of its supertypes.

I'm not sure we want to know that.  That said, the incomplete type is
much nicer.  Anybody wants to add a BiteSizedTask.

Paolo
