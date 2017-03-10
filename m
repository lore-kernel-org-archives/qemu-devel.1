Received: from eggs.gnu.org ([2001:4830:134:3::10]:48769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cmIzP-000719-ND
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cmIzM-00051B-KJ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:45:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cmIzM-0004z0-BW
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 06:45:40 -0500
Date: Fri, 10 Mar 2017 11:45:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170310114531.GB2480@work-vm>
References: <20170310012339.GA7400@flamenco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170310012339.GA7400@flamenco>
Subject: Re: [Qemu-devel] Benchmarking linux-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>

* Emilio G. Cota (cota@braap.org) wrote:
> Hi all,
> 
> Inspired by SimBench[1], I have written a set of scripts ("DBT-bench")
> to easily obtain and plot performance numbers for linux-user.
> 
> The (Perl) scripts are available here:
>   https://github.com/cota/dbt-bench
> [ It's better to clone with --recursive because the benchmarks
> (NBench) are pulled as a submodule. ]
> 
> I'm using NBench because (1) it's just a few files and they take
> very little time to run (~5min per QEMU version, if performance
> on the host machine is stable), (2) AFAICT its sources are in the
> public domain (whereas SPEC's sources cannot be redistributed),
> and (3) with NBench I get results similar to SPEC's.

Does NBench include anything with lots of small processes, or a large
chunk of code.  Using benchmarks with small code tends to skew DBT optimisations
towards very heavy block optimisation that dont work in real applications where
the cost of translation can hurt if it's too high.

> Here are linux-user performance numbers from v1.0 to v2.8 (higher
> is better):
> 
>                         x86_64 NBench Integer Performance
>                  Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz                
>                                                                                
>   36 +-+-+---+---+---+--+---+---+---+---+---+---+---+---+--+---+---+---+-+-+   
>      |   +   +   +   +  +   +   +   +   +   +   +   +   +  +   +   +  ***  |   
>   34 +-+                                                             #*A*+-+   
>      |                                                            *A*      |   
>   32 +-+                                                          #      +-+   
>   30 +-+                                                          #      +-+   
>      |                                                           #         |   
>   28 +-+                                                        #        +-+   
>      |                                 *A*#*A*#*A*#*A*#*A*#     #          |   
>   26 +-+                   *A*#*A*#***#    ***         ******#*A*        +-+   
>      |                     #       *A*                    *A* ***          |   
>   24 +-+                  #                                              +-+   
>   22 +-+                 #                                               +-+   
>      |             #*A**A*                                                 |   
>   20 +-+       #*A*                                                      +-+   
>      |  *A*#*A*  +   +  +   +   +   +   +   +   +   +   +  +   +   +   +   |   
>   18 +-+-+---+---+---+--+---+---+---+---+---+---+---+---+--+---+---+---+-+-+   
>        v1.v1.1v1.2v1.v1.4v1.5v1.6v1.7v2.0v2.1v2.2v2.3v2.v2.5v2.6v2.7v2.8.0     
>                                   QEMU version                                 

Nice, there was someone on list complaining about 2.6 being slower for them.

>                      x86_64 NBench Floating Point Performance                  
>                   Host: Intel(R) Xeon(R) CPU E5-2690 0 @ 2.90GHz               
>                                                                                
>   1.88 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+   
>        |   +   +  +  *A*#*A*  +  +   +   +   +   +  +   +   +   +  +   +   |   
>   1.86 +-+           *** ***                                             +-+   
>        |            #       #   *A*#***                                    |   
>        |      *A*# #         # ##   *A*                                    |   
>   1.84 +-+    #  *A*         *A*      #                                  +-+   
>        |      #                        #                              *A*  |   
>   1.82 +-+   #                          #                            ##  +-+   
>        |     #                          *A*#                        #      |   
>    1.8 +-+  #                               #  #*A*               *A*    +-+   
>        |    #                               *A*   #                #       |   
>   1.78 +-+*A*                                      #       *A*    #      +-+   
>        |                                           #   ***#  #    #        |   
>        |                                           *A*#*A*    #  #         |   
>   1.76 +-+                                         ***         # #       +-+   
>        |   +   +  +   +   +   +  +   +   +   +   +  +   +   +  *A* +   +   |   
>   1.74 +-+-+---+--+---+---+---+--+---+---+---+---+--+---+---+---+--+---+-+-+   
>          v1.v1.v1.2v1.3v1.4v1.v1.6v1.7v2.0v2.1v2.v2.3v2.4v2.5v2.v2.7v2.8.0     
>                                    QEMU version                                

I'm assuming the dips are where QEMU fixed something and cared about corner
cases/accuracy?

Dave

> Same plots, in PNG: http://imgur.com/a/nF7Ls
> 
> These plots are obtained simply by running
> 	$ QEMU_PATH=path/to/qemu QEMU_ARCH=x86_64 make -j
> from dbt-bench, although note that some user intervention was needed
> to compile old QEMU versions.
> 
> I think having some well-defined, easy-to-run benchmarks (even
> if far from perfect, like these) to aid development is better
> than not having any. My hope is that having these will encourage
> future performance improvements to the emulation loop and TCG -- or
> at least serve as a warning when performance regresses excessively :-)
> 
> Let me know if you find this work useful.
> 
> Thanks,
> 
> 		Emilio
> 
> [1] https://bitbucket.org/simbench/simbench
> Simbench's authors have a paper on it, although it is not publicly
> available yet (will be presented at the ISPASS'17 conference in April).
> The abstract can be accessed here though: http://tinyurl.com/hahb4yj
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
