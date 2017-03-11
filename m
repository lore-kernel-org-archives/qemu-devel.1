Received: from eggs.gnu.org ([2001:4830:134:3::10]:58215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cmWcU-00007w-HL
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cmWcQ-0006lI-4V
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:18:58 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1cmWcP-0006kd-TZ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 21:18:54 -0500
Date: Fri, 10 Mar 2017 21:18:51 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170311021851.GA26530@flamenco>
References: <20170310012339.GA7400@flamenco>
 <20170310114531.GB2480@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310114531.GB2480@work-vm>
Subject: Re: [Qemu-devel] Benchmarking linux-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

On Fri, Mar 10, 2017 at 11:45:33 +0000, Dr. David Alan Gilbert wrote:
> * Emilio G. Cota (cota@braap.org) wrote:
> >   https://github.com/cota/dbt-bench
> > I'm using NBench because (1) it's just a few files and they take
> > very little time to run (~5min per QEMU version, if performance
> > on the host machine is stable), (2) AFAICT its sources are in the
> > public domain (whereas SPEC's sources cannot be redistributed),
> > and (3) with NBench I get results similar to SPEC's.
> 
> Does NBench include anything with lots of small processes, or a large
> chunk of code.  Using benchmarks with small code tends to skew DBT optimisations
> towards very heavy block optimisation that dont work in real applications where
> the cost of translation can hurt if it's too high.

Yes this is a valid point.

I haven't looked at the NBench code in detail, but I'd expect all programs
in the suite to be small and have hotspots (this is consistent with
the fact that performance doesn't change even if the TB hash table
isn't used, i.e. the loops are small enough to remain in tb_jmp_cache.)
IOW, we'd be mostly measuring the quality of the translated code,
not the translation overhead.

It seems that a good benchmark to take translation overhead into account
would be gcc/perlbench from SPEC (see [1]; ~20% of exec time is spent
on translation). Unfortunately, none of them can be redistributed.

I'll consider other options. For instance, I looked today at using golang's
compilation tests, but they crash under qemu-user. I'll keep looking
at other options -- the requirement is to have something that is easy
to build (i.e. gcc is not an option) and that it runs fast.

A hack that one can do to measure code translation as opposed to execution
is to disable caching with a 2-liner to avoid insertions to the TB hash
table and tb_jmp_cache. The problem is that then we basically just
measure code translation performance, which isn't really realistic
either.

In any case, note that most efforts I've seen to compile very good code
(with QEMU or other cross-ISA DBT), do some sort of profiling so that
only hot blocks are optimized -- see for example [1] and [2].

[1] "Characterization of Dynamic Binary Translation Overhead".
    Edson Borin and Youfeng Wu. IISWC 2009.
    http://amas-bt.cs.virginia.edu/2008proceedings/AmasBT2008.pdf#page=4

[2] "HQEMU: a multi-threaded and retargetable dynamic binary translator
    on multicores".
    Ding-Yong Hong, Chun-Chen Hsu, Pen-Chung Yew, Jan-Jan Wu, Wei-Chung Hsu
    Pangfeng Liu, Chien-Min Wang and Yeh-Ching Chung. CGO 2012.
    http://www.iis.sinica.edu.tw/papers/dyhong/18239-F.pdf


> > Here are linux-user performance numbers from v1.0 to v2.8 (higher
> > is better):
> > 
> >                         x86_64 NBench Integer Performance
> >                  Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz                
> >                                                                                
> >   36 +-+-+---+---+---+--+---+---+---+---+---+---+---+---+--+---+---+---+-+-+   
> >      |   +   +   +   +  +   +   +   +   +   +   +   +   +  +   +   +  ***  |   
> >   34 +-+                                                             #*A*+-+   
> >      |                                                            *A*      |   
> >   32 +-+                                                          #      +-+   
> >   30 +-+                                                          #      +-+   
> >      |                                                           #         |   
> >   28 +-+                                                        #        +-+   
> >      |                                 *A*#*A*#*A*#*A*#*A*#     #          |   
> >   26 +-+                   *A*#*A*#***#    ***         ******#*A*        +-+   
> >      |                     #       *A*                    *A* ***          |   
> >   24 +-+                  #                                              +-+   
> >   22 +-+                 #                                               +-+   
> >      |             #*A**A*                                                 |   
> >   20 +-+       #*A*                                                      +-+   
> >      |  *A*#*A*  +   +  +   +   +   +   +   +   +   +   +  +   +   +   +   |   
> >   18 +-+-+---+---+---+--+---+---+---+---+---+---+---+---+--+---+---+---+-+-+   
> >        v1.v1.1v1.2v1.v1.4v1.5v1.6v1.7v2.0v2.1v2.2v2.3v2.v2.5v2.6v2.7v2.8.0     
> >                                   QEMU version                                 
> 
> Nice, there was someone on list complaining about 2.6 being slower for them.
> 
> >                      x86_64 NBench Floating Point Performance                  
> >                   Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz               
> >                                                                                
> >   1.88 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+   
> >        |   +   +  +  *A*#*A*  +  +   +   +   +   +  +   +   +   +  +   +   |   
> >   1.86 +-+           *** ***                                             +-+   
> >        |            #       #   *A*#***                                    |   
> >        |      *A*# #         # ##   *A*                                    |   
> >   1.84 +-+    #  *A*         *A*      #                                  +-+   
> >        |      #                        #                              *A*  |   
> >   1.82 +-+   #                          #                            ##  +-+   
> >        |     #                          *A*#                        #      |   
> >    1.8 +-+  #                               #  #*A*               *A*    +-+   
> >        |    #                               *A*   #                #       |   
> >   1.78 +-+*A*                                      #       *A*    #      +-+   
> >        |                                           #   ***#  #    #        |   
> >        |                                           *A*#*A*    #  #         |   
> >   1.76 +-+                                         ***         # #       +-+   
> >        |   +   +  +   +   +   +  +   +   +   +   +  +   +   +  *A* +   +   |   
> >   1.74 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+   
> >          v1.v1.v1.2v1.3v1.4v1.v1.6v1.7v2.0v2.1v2.v2.3v2.4v2.5v2.v2.7v2.8.0     
> >                                    QEMU version                                
> 
> I'm assuming the dips are where QEMU fixed something and cared about corner
> cases/accuracy?

It'd be hard to say why the numbers vary across versions without running
a profiler and git bisect. I only know the reason for v2.7, where most if not all
of the improvement is due to the removal of tb_lock() when executing
code in qemu-user thanks to the QHT work.

		E.
